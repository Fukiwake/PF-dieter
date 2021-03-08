class DiariesController < ApplicationController

  def index
    following_ids = current_customer.followings.pluck(:id)
    blocking_ids = current_customer.blockings.pluck(:id)
    @diaries = Diary.where(customer_id: following_ids).where.not(customer_id: blocking_ids).page(params[:page]).per(20)
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def show
    @diary = Diary.find(params[:id])
    @new_diary = Diary.new
    @check_list_diary = @new_diary.check_list_diaries.new
    @diary_comment = DiaryComment.new
  end

  def new
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def create
    @diary = current_customer.diaries.new(diary_params)
    if @diary.save
      level_up(20, current_customer)
      previous_diary = current_customer.diaries.last(2)[0]
      if previous_diary.present?
        level_up(previous_diary.weight * 10 - @diary.weight * 10, current_customer)
        level_up(previous_diary.body_fat_percentage * 30 - @diary.body_fat_percentage * 30, current_customer)
      end
      flash[:notice] = "日記を投稿しました"
      redirect_to diaries_path
    else
      @diary.check_list_diaries.destroy_all
      @check_list_diary = @diary.check_list_diaries.new
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def update
    diary = Diary.find(params[:id])
    if diary.update(diary_params)
      flash[:notice] = "日記を編集しました"
      redirect_to diary_path(diary)
    else
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body, :weight, :body_fat_percentage, :post_date, :image, check_list_diaries_attributes: [:check_list_id, :_destroy, :id])
  end
end
