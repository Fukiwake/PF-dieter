class DietMethodFavoritesController < ApplicationController
  
  def create
    @diet_method = DietMethod.find(params[:diet_method_id])
    favorite = current_customer.diet_method_favorites.new(diet_method_id: @diet_method.id)
    favorite.save
  end
  
  def destroy
    @diet_method = DietMethod.find(params[:diet_method_id])
    favorite = DietMethodFavorite.find_by(diet_method_id: params[:diet_method_id])
    favorite.destroy
  end
  
end
