class FindersController < ApplicationController
  before_action :set_new_diary

  def finder
    if params[:q].present?
      params[:q][:name_or_introduce_cont_all] = params[:q][:name_or_introduce_cont_all].split(/[[:blank:]]+/)
      params[:q][:title_or_body_or_customer_name_cont_all] = params[:q][:name_or_introduce_cont_all]
      params[:q][:title_or_way_or_customer_name_cont_all] = params[:q][:name_or_introduce_cont_all]
    end
    @customer_search = Customer.includes(:diaries).ransack(params[:q])
    @customers = @customer_search.result(distinct: true).page(params[:page]).per(20)
    @diary_search = Diary.includes(:customer,:check_list_diaries, :diary_images, :diary_favorites, :diary_comments).ransack(params[:q])
    @diaries = @diary_search.result(distinct: true).page(params[:page]).per(20)
    @diet_method_search = DietMethod.includes(:customer, :diet_method_images, :diet_method_favorites, :diet_method_comments, :tag_taggings, :tags).ransack(params[:q])
    @diet_methods = @diet_method_search.result(distinct: true).page(params[:page]).per(20)
  end
end
