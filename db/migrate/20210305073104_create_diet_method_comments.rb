class CreateDietMethodComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diet_method_comments do |t|
      t.integer :customer_id, null: false
      t.integer :diet_method_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
