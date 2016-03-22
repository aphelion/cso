class CreateTicketPurchases < ActiveRecord::Migration
  def change
    create_table :ticket_purchases do |t|
      t.belongs_to :ticket, null: true, index: true, foreign_key: true
      t.belongs_to :event, null: true, index: true, foreign_key: true
      t.belongs_to :user, null: true, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
