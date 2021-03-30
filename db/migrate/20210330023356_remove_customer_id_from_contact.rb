class RemoveCustomerIdFromContact < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :customer_id, :integer
  end
end
