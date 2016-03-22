class TicketPurchase < ActiveRecord::Base
  belongs_to :ticket_option
  belongs_to :event
  belongs_to :user
end
