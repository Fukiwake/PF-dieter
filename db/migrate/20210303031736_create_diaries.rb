class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.float :weight, null: false
      t.float :body_fat_percentage
      t.date :post_date, null: false
      t.string :image_id

      t.timestamps
    end
    
    add_index :diaries, :title
    add_index :diaries, :body
    add_index :diaries, :weight
    add_index :diaries, :body_fat_percentage
  end
end
