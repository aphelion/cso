class TicketPurchase < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :event
  belongs_to :user
end
