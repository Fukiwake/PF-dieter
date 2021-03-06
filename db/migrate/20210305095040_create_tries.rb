class CreateTries < ActiveRecord::Migration[5.2]
  def change
    create_table :tries do |t|
      t.integer :customer_id, null: false
      t.integer :method_id, null: false

      t.timestamps
    end
  end
end
