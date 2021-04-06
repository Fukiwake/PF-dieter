class DietMethodFavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diet_method = DietMethod.find(params[:diet_method_id])
    favorite = current_customer.diet_method_favorites.new(diet_method_id: @diet_method.id)
    favorite.save
    all_favorite_count = current_customer.diary_favorites.count + current_customer.diet_method_favorites.count
    if all_favorite_count == 5
      get_achievement(current_customer, 6)
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
