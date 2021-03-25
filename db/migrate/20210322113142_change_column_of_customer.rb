class ChangeColumnOfCustomer < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :birthyear, :text
    remove_column :customers, :birthdate, :date
    add_column :customers, :age, :integer
  end
end
