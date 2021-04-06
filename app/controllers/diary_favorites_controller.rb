class DiaryFavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diary = Diary.find(params[:diary_id])
    favorite = current_customer.diary_favorites.new(diary_id: @diary.id)
    favorite.save
    all_favorite_count = current_customer.diary_favorites.count + current_customer.diet_method_favorites.count
    if all_favorite_count == 5
      get_achievement(current_customer, 6)
    end
    @diary.create_notification_favorite(current_customer)
    respond_to do |format|
      format.html { redirect_to diaries_path }
      format.js
    end
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = DiaryFavorite.find_by(diary_id: params[:diary_id])
    favorite.destroy
  end
end
