class CreateCustomerDietStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_diet_styles do |t|
      t.integer :customer_id
      t.integer :diet_style_id

      t.timestamps
    end
  end
end
