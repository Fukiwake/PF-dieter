class AddBodyToContact < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :body, :te
    add_column :contacts, :body, :text
  end
end
