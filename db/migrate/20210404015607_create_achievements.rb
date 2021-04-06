class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :difficulty, null: false
      t.string :batch, null: false

      t.timestamps
    end
  end
end
