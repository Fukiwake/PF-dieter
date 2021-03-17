class ChangeCustomersColumnToNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :customers, :gender, :integer, null: true
    change_column :customers, :birthyear, :text, null: true
    change_column :customers, :birthdate, :date, null: true
    change_column :customers, :height, :float, null: true
    change_column :customers, :target_weight, :float, null: true
    change_column :customers, :name, :string, null: true
  end

  def down
    change_column :customers, :gender, :integer, null: false
    change_column :customers, :birthyear, :text, null: false
    change_column :customers, :birthdate, :date, null: false
    change_column :customers, :height, :float, null: false
    change_column :customers, :target_weight, :float, null: false
    change_column :customers, :name, :string, null: false
  end
end
