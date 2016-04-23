class EventPurchase < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :ticket_purchase, class_name: 'ProductPurchase', foreign_key: 'ticket_purchase_id'
  has_and_belongs_to_many :addon_purchases, class_name: 'ProductPurchase', join_table: :event_purchases_addon_purchases
end
