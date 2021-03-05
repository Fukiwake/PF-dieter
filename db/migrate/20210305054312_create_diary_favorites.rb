class CreateDiaryFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_favorites do |t|
      t.integer :customer_id, null: false
      t.integer :diary_id, null: false

      t.timestamps
    end
  end
end
