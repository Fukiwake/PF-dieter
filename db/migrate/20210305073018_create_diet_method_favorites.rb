class CreateDietMethodFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :diet_method_favorites do |t|
      t.integer :customer_id, null: false
      t.integer :diet_method_id, null: false

      t.timestamps
    end
  end
end
