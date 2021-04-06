class AddDefaultToCustomersAchivementCount < ActiveRecord::Migration[5.2]
  def up
    change_column :customers, :achievement_count, :integer, default: 0
  end
  # 変更前の状態
  def down
    change_column :customers, :achievement_count, :integer
  end
end
