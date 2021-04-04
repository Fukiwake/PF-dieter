class TriesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diet_method = DietMethod.find(params[:diet_method_id])
    try = current_customer.tries.new(diet_method_id: @diet_method.id)
    try.save
    if CustomerAchievement.where(customer_id: current_customer.id, achievement_id: 5, achievement_status: true).blank?
      CustomerAchievement.create(customer_id: current_customer.id, achievement_id: 5, achievement_status: true)
      flash.now[:achievement] = "5"
      level_up(10, current_customer)
    end
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def destroy
    @diet_method = DietMethod.find(params[:diet_method_id])
    try = Try.find_by(diet_method_id: params[:diet_method_id])
    try.destroy
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end
end
