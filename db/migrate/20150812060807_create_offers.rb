class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :product_id
      t.text :description
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
