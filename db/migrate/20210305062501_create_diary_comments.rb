class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_comments do |t|
      t.integer :customer_id
      t.integer :diary_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
