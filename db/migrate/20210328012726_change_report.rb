class ChangeReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :visitor_id, :integer
    add_column :reports, :visited_id, :integer
    remove_column :reports, :customer_id, :integer
  end
end
