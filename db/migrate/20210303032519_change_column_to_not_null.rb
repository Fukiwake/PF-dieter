class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :diaries, :title, :string, null: true
    change_column :diaries, :body, :text, null: true
  end

  def down
    change_column :diaries, :title, :string, null: false
    change_column :diaries, :body, :text, null: false
  end
end
