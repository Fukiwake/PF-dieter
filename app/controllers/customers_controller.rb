class CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(20)
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
  end

end
