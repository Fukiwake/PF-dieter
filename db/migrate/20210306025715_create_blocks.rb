class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.integer :blocker_id, foreign_key: true
      t.integer :blocked_id, foreign_key: true

      t.timestamps
    end
    add_index :blocks, :blocker_id
    add_index :blocks, :blocked_id
    add_index :blocks, [:blocker_id, :blocked_id], unique: true
  end
end
