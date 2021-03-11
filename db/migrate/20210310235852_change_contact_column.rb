class ChangeContactColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :body, :integer
    add_column :contacts, :body, :text
  end
end
