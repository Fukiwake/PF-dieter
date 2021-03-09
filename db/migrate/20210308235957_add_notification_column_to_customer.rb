class AddNotificationColumnToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :all_notification, :boolean, default: true
  end
end
