class HomesController < ApplicationController
  def top
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def about
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end
end
