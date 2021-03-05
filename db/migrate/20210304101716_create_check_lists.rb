class CreateCheckLists < ActiveRecord::Migration[5.2]
  def change
    create_table :check_lists do |t|
      t.integer :method_id, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
