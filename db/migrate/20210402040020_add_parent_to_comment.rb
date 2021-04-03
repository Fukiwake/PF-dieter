class AddParentToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :diary_comments, :parent_id, :integer
    add_column :diet_method_comments, :parent_id, :integer
  end
end
