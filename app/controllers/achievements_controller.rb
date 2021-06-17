class AchievementsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_new_diary

  def index
  end

  def hidden_dumbbell
    get_achievement(current_customer, 15)
    redirect_to request.referer
  end

  def unlock
    achievement = Achievement.find(params[:id])
    if current_customer.achievement_count >= achievement.difficulty
      CustomerAchievement.create(customer_id: current_customer.id, achievement_id: params[:id])
      current_customer.update(achievement_count: current_customer.achievement_count - achievement.difficulty)
      flash[:notice] = "「#{Achievement.find(params[:id]).title}」を解除しました"
    else
      flash[:alert] = "所持バッチ数が足りません"
    end
    redirect_to customer_achievements_path(current_customer)
  end

end
