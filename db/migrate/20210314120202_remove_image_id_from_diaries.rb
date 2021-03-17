class RemoveImageIdFromDiaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :diaries, :image_id, :string
  end
end
