class DietMethodsController < ApplicationController

  def new
    @diet_method = DietMethod.new
    @check_list = @diet_method.check_lists.new
    @tags = DietMethod.tag_counts_on(:tags).most_used(20)
  end

  def create
    @diet_method = current_customer.diet_methods.new(diet_method_params)
    if @diet_method.save
      flash[:notice] = "ダイエット方法を投稿しました"
      redirect_to diet_methods_path
    else
      render :new
    end
  end

  def index
    @diet_methods = DietMethod.page(params[:page]).per(20)
    @tags = DietMethod.tag_counts_on(:tags).most_used(20) 
    if @tag = params[:tag]   # タグ検索用
      @diet_methods = DietMethod.tagged_with(params[:tag]).page(params[:page]).per(20)   # タグに紐付く投稿
    end
  end

  def show
    @diet_method = DietMethod.find(params[:id])
    @tags = @diet_method.tag_counts_on(:tags)
  end

  def edit
    @diet_method = DietMethod.find(params[:id])
  end

  def update
    diet_method = DietMethod.find(params[:id])
    if diet_method.update(diet_method_params)
      flash[:notice] = "ダイエット方法を編集しました"
      redirect_to diet_method_path(diet_method)
    else
      render :edit
    end
  end

  def destroy
    @diet_method = DietMethod.find(params[:id])
    @diet_method.destroy
    redirect_to diet_methods_path
  end

  private

  def diet_method_params
    params.require(:diet_method).permit(:title, :way, :attention, :image, :tag_list, check_lists_attributes: [:body, :_destroy, :id])
  end
end