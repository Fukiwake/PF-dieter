class AddColumnToCheckList < ActiveRecord::Migration[5.2]
  def change
    add_column :check_lists, :is_deleted, :boolean, default: false
  end
end
