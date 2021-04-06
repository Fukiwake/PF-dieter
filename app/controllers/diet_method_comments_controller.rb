class DietMethodCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diet_method_comment = current_customer.diet_method_comments.new(diet_method_comment_params)
    @diet_method = DietMethod.find(params[:diet_method_id])
    @diet_method_comment.diet_method_id = @diet_method.id
    @diet_method_comment.save
    #普通のコメントは投稿者に通知
    #返信はコメント主に通知
    if @diet_method_comment.parent_id.present?
      @diet_method.create_notification_reply(current_customer, @diet_method_comment.id)
    else
      @diet_method.create_notification_comment(current_customer, @diet_method_comment.id)
    end
    all_comment_count = current_customer.diary_comments.count + current_customer.diet_method_comments.count
    if all_comment_count == 5
      get_achievement(current_customer, 7)
    end
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
    @diet_method_comment_reply = DietMethodComment.new
  end

  def destroy
    @diet_method = DietMethod.find(params[:diet_method_id])
    @diet_method_comment = DietMethodComment.find_by(id: params[:id], diet_method_id: params[:diet_method_id])
    @parent_id = @diet_method_comment.parent_id
    @diet_method_comment.destroy
    @diet_method_comment_reply = DietMethodComment.new
  end

  private

  def diet_method_comment_params
    params.require(:diet_method_comment).permit(:body, :parent_id)
  end
end
