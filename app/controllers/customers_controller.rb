class CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(20)
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def show
    @customer = Customer.find(params[:id])
    @diaries = @customer.diaries.all.order(post_date: "ASC")
    # 日記を過去1年分に限定する
    if @diaries.present?
      @diaries = @diaries.get_one_year_diary
    end
    @weights = @diaries.pluck(:weight)
    @body_fat_percentages = @diaries.pluck(:body_fat_percentage)
    @dates = @diaries.pluck(:post_date)
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end
  
  def withdraw
    current_customer.is_deleted = true
    current_customer.save
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
  def followings
    customer = Customer.find(params[:id])
    @customers = customer.followings.page(params[:page]).per(20)
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end
  
  def followers
    customer = Customer.find(params[:id])
    @customers = customer.followers.page(params[:page]).per(20)
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end
end
