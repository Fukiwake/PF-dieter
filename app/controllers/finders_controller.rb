class FindersController < ApplicationController
  before_action :set_new_diary

  def finder
    if params[:q].present?
      unless params[:q][:name_or_introduce_cont_any].instance_of?(Array) || params[:q][:name_or_introduce_cont_any].empty?
        params[:q][:name_or_introduce_cont_any] = params[:q][:name_or_introduce_cont_any].split(/[[:blank:]]+/)
      end
      params[:q][:title_or_body_or_customer_name_cont_any] = params[:q][:name_or_introduce_cont_any]
      params[:q][:title_or_way_or_customer_name_cont_any] = params[:q][:name_or_introduce_cont_any]
    else
      flash[:alert] = "検索ワードを入力してください"
      redirect_to diaries_path
    end
    @customer_search = Customer.includes(:diaries).ransack(params[:q])
    @customers = @customer_search.result(distinct: true).order("created_at DESC").page(params[:page]).per(20)
    @diary_search = Diary.includes(:customer, :check_list_diaries, :diary_images, :diary_favorites, :diary_comments).ransack(params[:q])
    @diaries = @diary_search.result(distinct: true).order("created_at DESC").page(params[:page]).per(20)
    @diet_method_search = DietMethod.includes(:customer, :diet_method_images, :diet_method_favorites, :diet_method_comments, :tag_taggings, :tags).ransack(params[:q])
    @diet_methods = @diet_method_search.result(distinct: true).order("created_at DESC").page(params[:page]).per(20)
    get_achievement(current_customer, 10)
  end
end
