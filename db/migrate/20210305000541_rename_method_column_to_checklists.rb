class RenameMethodColumnToChecklists < ActiveRecord::Migration[5.2]
  def change
    rename_column :check_lists, :method_id, :diet_method_id
  end
end
