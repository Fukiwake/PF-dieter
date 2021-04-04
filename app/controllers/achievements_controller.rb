class AchievementsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_new_diary

  def index

  end
end
