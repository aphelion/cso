class CreateEventPurchases < ActiveRecord::Migration
  def change
    create_table :event_purchases do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :ticket_purchase_id, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :event_purchases, [:event_id, :user_id], unique: true
  end
end
