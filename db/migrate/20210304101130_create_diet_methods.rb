class CreateDietMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :diet_methods do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.text :way, null: false
      t.text :attention
      t.string :image_id

      t.timestamps
    end
    add_index :diet_methods, :title
  end
end
