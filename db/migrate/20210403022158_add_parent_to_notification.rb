class AddParentToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :diet_method_parent_id, :integer
    add_column :notifications, :diary_parent_id, :integer
  end
end
