class AddLevelToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :level, :integer, default: 1
  end
end
