class CreateCheckListDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :check_list_diaries do |t|
      t.integer :diary_id, null: false
      t.integer :check_list_id, null: false
      t.boolean :status

      t.timestamps
    end
  end
end
