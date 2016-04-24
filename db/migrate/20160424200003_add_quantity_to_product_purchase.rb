class AddQuantityToProductPurchase < ActiveRecord::Migration
  def change
    add_column :product_purchases, :quantity, :integer, default: 0
  end
end
