class RenameMethodColumnToTries < ActiveRecord::Migration[5.2]
  def change
    rename_column :tries, :method_id, :diet_method_id
  end
end
