class CreateProductPurchases < ActiveRecord::Migration
  def change
    create_table :product_purchases do |t|
      t.references :charge, index: true, foreign_key: true, null: false
      t.references :product, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
