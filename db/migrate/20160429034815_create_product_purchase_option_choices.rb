class CreateProductPurchaseOptionChoices < ActiveRecord::Migration
  def change
    create_table :product_purchase_option_choices do |t|
      t.references :product_purchase, index: true, null: false, foreign_key: true
      t.string :option, null: false
      t.string :choice, null: false

      t.timestamps null: false
    end
  end
end
