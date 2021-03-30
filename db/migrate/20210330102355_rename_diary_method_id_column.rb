class RenameDiaryMethodIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :diary_method_id, :diet_method_id
  end
end
