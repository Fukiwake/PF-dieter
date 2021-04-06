class CreateCustomerAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_achievements do |t|
      t.integer :customer_id, null: false
      t.integer :achievement_id, null: false
      t.boolean :achievement_status, default: false

      t.timestamps
    end
  end
end
