class ChangeTitleOfDiaries < ActiveRecord::Migration[5.2]
  def up
    change_column :diaries, :title, :string, default: '無題'
  end

  def down
    change_column :diaries, :title, :string
  end
end
