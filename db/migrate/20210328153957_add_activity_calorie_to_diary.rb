class AddActivityCalorieToDiary < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :activity_calorie, :integer
  end
end
