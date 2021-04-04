class DiaryFavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diary = Diary.find(params[:diary_id])
    favorite = current_customer.diary_favorites.new(diary_id: @diary.id)
    favorite.save
    all_favorite_count = current_customer.diary_favorites.count + current_customer.diet_method_favorites.count
    if CustomerAchievement.where(customer_id: current_customer.id, achievement_id: 6, achievement_status: true).blank? && all_favorite_count == 5
      CustomerAchievement.create(customer_id: current_customer.id, achievement_id: 6, achievement_status: true)
      flash.now[:achievement] = "6"
      level_up(10, current_customer)
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
