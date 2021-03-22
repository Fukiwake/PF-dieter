class Admin::DietMethodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_diet_method, only: [:show, :edit, :update]

  def index
    @diet_method_search = DietMethod.includes(:customer).ransack(params[:q])
    @diet_methods = @diet_method_search.result(distinct: true).page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end

  def update
    if @diet_method.update(diet_method_params)
      flash[:notice] = "ダイエット方法を編集しました"
      redirect_to admin_diet_method_path(@diet_method)
    else
      render :edit
    end
  end

  def destroy
    diet_method = DietMethod.find(params[:id])
    diet_method.destroy
    flash[:notice] = "ダイエット方法が削除されました"
    redirect_to admin_diet_methods_path
  end

  def destroy_all
    DietMethod.where(id: params[:diet_method_ids]).destroy_all
    flash[:notice] = "選択したダイエット方法が削除されました"
    redirect_to admin_diet_methods_path
  end

  private

  def diet_method_params
    params.require(:diet_method).permit(:title, :way, :attention, :image, :tag_list, diet_method_images_images: [], check_lists_attributes: [:body, :_destroy, :id])
  end

  def set_diet_method
    @diet_method = DietMethod.find(params[:id])
  end

end
