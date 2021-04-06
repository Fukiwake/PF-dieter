class DiaryCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diary_comment = current_customer.diary_comments.new(diary_comment_params)
    @diary = Diary.find(params[:diary_id])
    @diary_comment.diary_id = @diary.id
    @diary_comment.save
    #普通のコメントは投稿者に通知
    #返信はコメント主に通知
    if @diary_comment.parent_id.present?
      @diary.create_notification_reply(current_customer, @diary_comment.id)
    else
      @diary.create_notification_comment(current_customer, @diary_comment.id)
    end
    all_comment_count = current_customer.diary_comments.count + current_customer.diet_method_comments.count
    if all_comment_count == 5
      get_achievement(current_customer, 7)
    end
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
    @diary_comment_reply = DiaryComment.new
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @diary_comment = DiaryComment.find_by(id: params[:id], diary_id: params[:diary_id])
    @parent_id = @diary_comment.parent_id
    @diary_comment.destroy
    @diary_comment_reply = DiaryComment.new
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:body, :parent_id)
  end
end
