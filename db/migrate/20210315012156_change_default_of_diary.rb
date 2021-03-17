class ChangeDefaultOfDiary < ActiveRecord::Migration[5.2]
  def up
    change_column :diaries, :title, :string, default: nil
  end
  # 変更前の状態
  def down
    change_column :diaries, :title, :string, default: "無題"
  end
end
