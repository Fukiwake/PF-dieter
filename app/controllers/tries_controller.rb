class TriesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diet_method = DietMethod.find(params[:diet_method_id])
    try = current_customer.tries.new(diet_method_id: @diet_method.id)
    try.save
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
