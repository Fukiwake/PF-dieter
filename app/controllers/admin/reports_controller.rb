class Admin::ReportsController < ApplicationController

  def index
    @diaries = Diary.find(Report.pluck(:diary_id).uniq)
    @diaries = Kaminari.paginate_array(@diaries).page(params[:page]).per(20)
  end

end
