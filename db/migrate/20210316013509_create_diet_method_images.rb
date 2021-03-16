class CreateDietMethodImages < ActiveRecord::Migration[5.2]
  def change
    create_table :diet_method_images do |t|
      t.integer :diet_method_id, null: false
      t.string :image_id

      t.timestamps
      t.index ["diet_method_id"], name: "index_diet_method_images_on_diet_method_id"
    end
  end
end
