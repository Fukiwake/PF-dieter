class AddCalorieToDiary < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :food_calorie, :integer
  end
end
