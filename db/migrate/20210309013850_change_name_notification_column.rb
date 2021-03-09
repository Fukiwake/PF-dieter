class ChangeNameNotificationColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :diary_method_comment_id, :diet_method_comment_id
  end
end
