class CreateDietStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :diet_styles do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
