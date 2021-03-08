class DiaryCommentsController < ApplicationController
  
  def create
    diary_comment = current_customer.diary_comments.new(diary_comment_params)
    @diary = Diary.find(params[:diary_id])
    diary_comment.diary_id = @diary.id
    diary_comment.save
    @diary.create_notification_comment(current_customer, diary_comment.id)
  end
  
  def destroy
    @diary = Diary.find(params[:diary_id])
    DiaryComment.find_by(id: params[:id], diary_id: params[:diary_id]).destroy
  end
  
  private
  
  def diary_comment_params
    params.require(:diary_comment).permit(:body)
  end
end
