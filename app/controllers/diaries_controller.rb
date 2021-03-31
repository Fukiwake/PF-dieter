class DiariesController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :set_new_diary, except: [:show, :edit]
  before_action :set_diary, only: [:show, :edit, :update]

  def index
    withdraw_ids = Customer.where(is_deleted: true).pluck(:id)
    if customer_signed_in?
      following_ids = current_customer.followings.pluck(:id)
      blocking_ids = current_customer.blockings.pluck(:id)
      blocker_ids = current_customer.blockers.pluck(:id)
      all_diaries = Diary.includes(:customer, :check_list_diaries, :diary_images, :diary_favorites, :diary_comments).order("created_at DESC")
      @diaries = all_diaries.where(customer_id: following_ids).where.not(customer_id: blocking_ids).where.not(customer_id: blocker_ids).where.not(customer_id: withdraw_ids).or(all_diaries.where(customer_id: current_customer.id))
    else
      @diaries = Diary.includes(:customer, :check_list_diaries, :diary_images, :diary_favorites, :diary_comments).where.not(customer_id: withdraw_ids).order("created_at DESC")
    end
    if params[:q].present?
      unless params[:q][:title_or_body_or_customer_name_cont_any].instance_of?(Array) || params[:q][:title_or_body_or_customer_name_cont_any].empty?
        params[:q][:title_or_body_or_customer_name_cont_any] = params[:q][:title_or_body_or_customer_name_cont_any].split(/[\p{blank}\s]+/)
      end
    end
    @diary_search = @diaries.ransack(params[:q])
    @diaries = @diary_search.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    if @diary.customer.blocking?(current_customer)
      flash[:alert] = "ページが存在しません"
      redirect_to diaries_path
    end
    @new_diary = Diary.new
    @check_list_diary = @new_diary.check_list_diaries.new
    @diary_comment = DiaryComment.new
  end

  def new
  end

  def create
    if current_customer.diaries.find_by(post_date: "#{params[:diary]["post_date(1i)"]}-#{params[:diary]["post_date(2i)"]}-#{params[:diary]["post_date(3i)"]}").present?
      flash[:alert] = "同じ日付の日記がすでに投稿されています"
      render(:new) && return
    else
      @diary = current_customer.diaries.new(diary_params)
    end
    if @diary.title.blank?
      @diary.title = "日記"
    end
    if @diary.save
      # チェックされていないチェックリストのcheck_list_diary(中間テーブル)を作成
      current_customer.trying_diet_methods.each do |method|
        check_list_ids = method.check_lists.pluck(:id)
        check_list_ids.each do |check_list_id|
          @diary.check_list_diaries.where(check_list_id: check_list_id).first_or_create do |check_list_dairy|
            check_list_dairy.status = "false"
          end
        end
      end
      level_up(20, current_customer)
      previous_diary = current_customer.diaries.first(2)[1]
      if previous_diary.present?
        level_up(previous_diary.weight * 10 - @diary.weight * 10, current_customer)
        if previous_diary.body_fat_percentage.present? && @diary.body_fat_percentage.present?
          level_up(previous_diary.body_fat_percentage * 30 - @diary.body_fat_percentage * 30, current_customer)
        end
      end
      customer_ids = Relationship.where(followed_id: current_customer.id, notification: true).pluck(:follower_id)
      Customer.where(id: customer_ids).each do |customer|
        unless customer.blocking?(current_customer)
          customer.create_notification_diary(current_customer, @diary)
        end
      end
      flash[:notice] = "日記を投稿しました"
      redirect_to(diaries_path) && return
    else
      @diary.check_list_diaries.destroy_all
      render(:new) && return
    end
  end

  def edit
    @new_diary = Diary.new
    @check_list_diary = @new_diary.check_list_diaries.new
  end

  def update
    if @diary.update(diary_params)
      if @diary.check_list_diaries.present?
        @diary.check_list_diaries.update(status: false)
        if params[:diary][:check_list_diary].present?
          CheckListDiary.where(id: params[:diary][:check_list_diary][:id]).update(status: true)
        end
      end
      flash[:notice] = "日記を編集しました"
      redirect_to diary_path(@diary)
    else
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    flash[:notice] = "日記を削除しました"
    redirect_to diaries_path
  end

  def image_analysis
    require "google/cloud/vision"
    require "google/cloud/translate"
    project_id = "watchful-force-308204"
    language_code = 'ja'
    image_annotator = Google::Cloud::Vision.image_annotator
    file_name = File.open(params[:food_image].tempfile)
    response = image_annotator.label_detection image: file_name
    image_analysis_array = []
    response.responses.each do |res|
      res.label_annotations.each do |label|
        translate   = Google::Cloud::Translate.translation_v2_service project_id: project_id
        translation = translate.translate label.description, to: language_code
        image_analysis_array.push(translation.text.inspect.delete(%Q[/"]))
      end
    end


    require 'net/http'
    require 'json'

    # 1.urlを解析する
    p "#{image_analysis_array[0]}&q2=#{image_analysis_array[1]}&q3=#{image_analysis_array[2]}&q4=#{image_analysis_array[3]}&q5=#{image_analysis_array[4]}&q6=#{image_analysis_array[5]}&q7=#{image_analysis_array[6]}&q8=#{image_analysis_array[7]}&q9=#{image_analysis_array[8]}&q10=#{image_analysis_array[9]}"
    url = URI.encode("https://script.google.com/macros/s/AKfycbxE64MZNLxwqgS0sBhmsNfYvxJHKIC3iCmy9bnvJw7x8R4aR0R8ObO7_1w1_3Mk06Ym/exec?q=#{image_analysis_array[0]}&q2=#{image_analysis_array[1]}&q3=#{image_analysis_array[2]}&q4=#{image_analysis_array[3]}&q5=#{image_analysis_array[4]}&q6=#{image_analysis_array[5]}&q7=#{image_analysis_array[6]}&q8=#{image_analysis_array[7]}&q9=#{image_analysis_array[8]}&q10=#{image_analysis_array[9]}")
    url = URI.parse(url)
    # 2.httpの通信を設定する
    # 通信先のホストやポートを設定
    https = Net::HTTP.new(url.host, url.port)
    # httpsで通信する場合、use_sslをtrueにする
    https.use_ssl = true
    # 3.リクエストを作成する
    request = Net::HTTP::Get.new(url)
    # 4.リクエストを投げる/レスポンスを受け取る
    response = https.request(request)
    if response.code == "302"
      response = Net::HTTP.get_response(URI.parse(response.header['location']))
    end
    # 5.データを変換する
    @result = JSON.parse(response.body)

  end


  private

  def diary_params
    params.require(:diary).permit(:title, :body, :weight, :body_fat_percentage, :post_date, :food_calorie, :activity_calorie, diary_images_images: [], check_list_diaries_attributes: [:check_list_id, :_destroy, :id])
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end
end
