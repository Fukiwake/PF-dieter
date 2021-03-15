class CreateDiaryImages < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_images do |t|
      t.integer :diary_id, null: false
      t.string :image_id

      t.timestamps
      t.index ["diary_id"], name: "index_diary_images_on_diary_id"
    end

  end
end
