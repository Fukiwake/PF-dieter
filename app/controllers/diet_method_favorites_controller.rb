class DietMethodFavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diet_method = DietMethod.find(params[:diet_method_id])
    favorite = current_customer.diet_method_favorites.new(diet_method_id: @diet_method.id)
    favorite.save
    all_favorite_count = current_customer.diary_favorites.count + current_customer.diet_method_favorites.count
    if CustomerAchievement.where(customer_id: current_customer.id, achievement_id: 6, achievement_status: true).blank? && all_favorite_count == 5
      CustomerAchievement.create(customer_id: current_customer.id, achievement_id: 6, achievement_status: true)
      flash.now[:achievement] = "6"
      level_up(10, current_customer)
    end
    @diet_method.create_notification_favorite(current_customer)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @diet_method = DietMethod.find(params[:diet_method_id])
    favorite = DietMethodFavorite.find_by(diet_method_id: params[:diet_method_id])
    favorite.destroy
  end
end
