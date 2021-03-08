class DiaryFavoritesController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id])
    favorite = current_customer.diary_favorites.new(diary_id: @diary.id)
    favorite.save
    @diary.create_notification_favorite(current_customer)
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = DiaryFavorite.find_by(diary_id: params[:diary_id])
    favorite.destroy
  end
end
