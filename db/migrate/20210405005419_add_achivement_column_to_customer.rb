class AddAchivementColumnToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :achievement_count, :integer
  end
end
