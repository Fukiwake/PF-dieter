class Admin::DiariesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_diary, only: [:show, :edit, :update]

  def index
    @diary_search = Diary.includes(:customer).ransack(params[:q])
    @diaries = @diary_search.result(distinct: true).page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      flash[:notice] = "日記を編集しました"
      redirect_to admin_diary_path(@diary)
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:notice] = "日記が削除されました"
    redirect_to admin_diaries_path
  end

  def destroy_all
    Diary.where(id: params[:diary_ids]).destroy_all
    flash[:notice] = "選択した日記が削除されました"
    redirect_to admin_diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body, :weight, :body_fat_percentage, :post_date, :image, check_list_diaries_attributes: [:check_list_id, :_destroy, :id])
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end
end
