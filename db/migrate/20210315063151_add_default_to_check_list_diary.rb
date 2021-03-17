class AddDefaultToCheckListDiary < ActiveRecord::Migration[5.2]
  def up
    change_column :check_list_diaries, :status, :boolean, default: true
  end
  # 変更前の状態
  def down
    change_column :check_list_diaries, :status, :boolean
  end
end
