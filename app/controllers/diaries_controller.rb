class DiariesController < ApplicationController

  def index
    @diaries = Diary.page(params[:page]).per(20)
  end

  def show
    @diary = Diary.find(params[:id])
    @diary_comment = DiaryComment.new
  end

  def new
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def create
    @diary = current_customer.diaries.new(diary_params)
    if @diary.save
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
