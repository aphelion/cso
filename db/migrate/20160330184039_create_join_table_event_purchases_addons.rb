class CreateJoinTableEventPurchasesAddons < ActiveRecord::Migration
  def change
    create_join_table :event_purchases, :product_purchases, {table_name: 'event_purchases_addon_purchases'} do |t|
      t.index [:event_purchase_id, :product_purchase_id], unique: true, name: 'index_event_purchases_addon_purchases'
    end
  end
end
