class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.references :product, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :choices, null: false, array: true, default: []

      t.timestamps null: false
    end
  end
end
