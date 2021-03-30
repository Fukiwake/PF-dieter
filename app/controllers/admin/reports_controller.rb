class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @diaries = Diary.includes(:customer).where(id: Report.pluck(:diary_id).uniq)
    @diaries = Kaminari.paginate_array(@diaries).page(params[:page]).per(20)
    @diary_comments = DiaryComment.includes(:customer, :diary).where(id: Report.pluck(:diary_comment_id).uniq)
    @diary_comments = Kaminari.paginate_array(@diary_comments).page(params[:page]).per(20)
    @diet_methods = DietMethod.includes(:customer).where(id: Report.pluck(:diet_method_id).uniq)
    @diet_methods = Kaminari.paginate_array(@diet_methods).page(params[:page]).per(20)
    @diet_method_comments = DietMethodComment.includes(:customer, :diet_method).where(id: Report.pluck(:diet_method_comment_id).uniq)
    @diet_method_comments = Kaminari.paginate_array(@diet_method_comments).page(params[:page]).per(20)
    @customers = Customer.where(id: Report.pluck(:visited_id).uniq, is_deleted: false)
    @customers = Kaminari.paginate_array(@customers).page(params[:page]).per(20)
  end

  def diary_destroy_all
    if params[:report].present?
      Report.where(diary_id: params[:diary_ids]).destroy_all
      flash[:notice] = "選択された報告が解決済になりました"
      redirect_to admin_reports_path
    else
      Diary.where(id: params[:diary_ids]).destroy_all
      flash[:notice] = "選択された日記が削除されました"
      redirect_to admin_reports_path
    end
  end

  def diet_method_destroy_all
    if params[:report].present?
      Report.where(diet_method_id: params[:diet_method_ids]).destroy_all
      flash[:notice] = "選択された報告が解決済になりました"
      redirect_to admin_reports_path
    else
      DietMethod.where(id: params[:diet_method_ids]).destroy_all
      flash[:notice] = "選択されたダイエット方法が削除されました"
      redirect_to admin_reports_path
    end
  end

  def diary_comment_destroy_all
    if params[:report].present?
      Report.where(diary_comment_id: params[:diary_comment_ids]).destroy_all
      flash[:notice] = "選択された報告が解決済になりました"
      redirect_to admin_reports_path
    else
      DiaryComment.where(id: params[:diary_comment_ids]).destroy_all
      flash[:notice] = "選択された日記コメントが削除されました"
      redirect_to admin_reports_path
    end
  end

  def diet_method_comment_destroy_all
    if params[:report].present?
      Report.where(diet_method_comment_id: params[:diet_method_comment_ids]).destroy_all
      flash[:notice] = "選択された報告が解決済になりました"
      redirect_to admin_reports_path
    else
      DiaryComment.where(id: params[:diary_comment_ids]).destroy_all
      flash[:notice] = "選択された日記コメントが削除されました"
      redirect_to admin_reports_path
    end
  end

  def withdraw_all
    if params[:report].present?
      Report.where(visited_id: params[:customer_ids]).destroy_all
      flash[:notice] = "選択された報告が解決済になりました"
      redirect_to admin_reports_path
    else
      Customer.where(id: params[:customer_ids]).update(is_deleted: true)
      flash[:notice] = "選択された会員が退会されました"
      redirect_to admin_reports_path
    end
  end
end
