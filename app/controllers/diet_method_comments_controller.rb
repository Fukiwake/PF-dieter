class DietMethodCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    diet_method_comment = current_customer.diet_method_comments.new(diet_method_comment_params)
    @diet_method = DietMethod.find(params[:diet_method_id])
    diet_method_comment.diet_method_id = @diet_method.id
    diet_method_comment.save
    @diet_method.create_notification_comment(current_customer, diet_method_comment.id)
  end

  def destroy
    @diet_method = DietMethod.find(params[:diet_method_id])
    DietMethodComment.find_by(id: params[:id], diet_method_id: params[:diet_method_id]).destroy
  end

  private

  def diet_method_comment_params
    params.require(:diet_method_comment).permit(:body)
  end

end
