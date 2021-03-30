class DietMethodsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :set_new_diary, only: [:new, :index, :edit, :show]
  before_action :set_diet_method, only: [:show, :edit, :update]

  def new
    @diet_method = DietMethod.new
    @check_list = @diet_method.check_lists.new
  end

  def create
    @diet_method = current_customer.diet_methods.new(diet_method_params)
    if @diet_method.save
      Try.create(customer_id: current_customer.id, diet_method_id: @diet_method.id)
      @diet_method.check_lists.each do |check_list|
        if check_list.body.blank?
          check_list.destroy
        end
      end
      level_up(20, current_customer)
      customer_ids = Relationship.where(followed_id: current_customer.id, notification: true).pluck(:follower_id)
      Customer.where(id: customer_ids).each do |customer|
        unless customer.blocking?(current_customer)
          customer.create_notification_diet_method(current_customer, @diet_method)
        end
      end
      flash[:notice] = "ダイエット方法を投稿しました"
      redirect_to diet_methods_path
    else
      render :new
    end
  end

  def index
    withdraw_ids = Customer.where(is_deleted: true).pluck(:id)
    if customer_signed_in?
      blocking_ids = current_customer.blockings.pluck(:id)
      blocker_ids = current_customer.blockers.pluck(:id)
      withdraw_ids = Customer.where(is_deleted: true).pluck(:id)
      all_diet_methods = DietMethod.includes(:customer, :diet_method_images, :diet_method_favorites, :diet_method_comments, :tag_taggings, :tags).order("created_at DESC")
      @diet_methods = all_diet_methods.where.not(customer_id: blocking_ids).where.not(customer_id: blocker_ids).where.not(customer_id: withdraw_ids)
    else
      @diet_methods = DietMethod.includes(:customer, :diet_method_images, :diet_method_favorites, :diet_method_comments, :tag_taggings, :tags).where.not(customer_id: withdraw_ids).order("created_at DESC")
    end
    @tags = DietMethod.tag_counts_on(:tags).most_used(20)
    if @tag = params[:tag]
      @diet_methods = @diet_methods.tagged_with(params[:tag]).page(params[:page]).per(20)
    end
    if params[:q].present?
      unless params[:q][:title_or_way_or_customer_name_cont_any].instance_of?(Array) || params[:q][:title_or_way_or_customer_name_cont_any].empty?
        params[:q][:title_or_way_or_customer_name_cont_any] = params[:q][:title_or_way_or_customer_name_cont_any].split(/[[:blank:]]+/)
      end
    end
    @diet_method_search = @diet_methods.ransack(params[:q])
    @diet_methods = @diet_method_search.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    if @diet_method.customer.blocking?(current_customer)
      flash[:alert] = "ページが存在しません"
      redirect_to diet_methods_path
    end
    @tags = @diet_method.tag_counts_on(:tags)
    @diet_method_comment = DietMethodComment.new
  end

  def edit
    @check_list = @diet_method.check_lists.where(is_deleted: false)
  end

  def update
    if @diet_method.update(diet_method_params)
      @diet_method.check_lists.where(is_deleted: true).update(diet_method_id: "")
      flash[:notice] = "ダイエット方法を編集しました"
      redirect_to diet_method_path(@diet_method)
    else
      render :edit
    end
  end

  def destroy
    @diet_method = DietMethod.find(params[:id])
    @diet_method.destroy
    flash[:notice] = "ダイエット方法を削除しました"
    redirect_to diet_methods_path
  end

  private

  def diet_method_params
    params.require(:diet_method).permit(:title, :way, :attention, :image, :tag_list, diet_method_images_images: [], check_lists_attributes: [:body, :is_deleted, :id])
  end

  def set_diet_method
    @diet_method = DietMethod.find(params[:id])
  end
end
