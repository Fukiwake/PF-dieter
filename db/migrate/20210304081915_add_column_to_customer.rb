class AddColumnToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :diet_style1, :boolean, default: false
    add_column :customers, :diet_style2, :boolean, default: false
    add_column :customers, :diet_style3, :boolean, default: false
    add_column :customers, :diet_style4, :boolean, default: false
  end
end
