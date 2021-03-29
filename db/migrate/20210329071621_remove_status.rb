class RemoveStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :diaries, :is_deleted, :boolean
    remove_column :diary_comments, :is_deleted, :boolean
    remove_column :diet_method_comments, :is_deleted, :boolean
    remove_column :diet_methods, :is_deleted, :boolean
  end
end
