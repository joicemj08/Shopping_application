class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.float :unit_price
      t.float :quantity

      t.timestamps null: false
    end
  end
end
