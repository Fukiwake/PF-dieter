class AddColumnsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :is_deleted, :boolean, default: false
    add_column :diet_methods, :is_deleted, :boolean, default: false
    add_column :diary_comments, :is_deleted, :boolean, default: false
    add_column :diet_method_comments, :is_deleted, :boolean, default: false
  end
end
