class ReportsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    report = Report.new(
      diary_id: params[:diary_id], 
      diary_comment_id: params[:diary_comment_id], 
      diet_method_id: params[:diet_method_id], 
      diet_method_comment_id: params[:diet_method_comment_id], 
      visited_id: params[:visited_id]
    )
    report.visitor_id = current_customer.id
    report.save
    flash[:notice] = "報告しました"
    redirect_to request.referer
  end
  
end
