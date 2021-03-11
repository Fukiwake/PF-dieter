class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id
      t.integer :diary_id
      t.integer :diet_method_id
      t.integer :diary_comment_id
      t.integer :diet_method_comment_id

      t.timestamps
    end
  end
end
