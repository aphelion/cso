class TicketOption < ActiveRecord::Base
  belongs_to :event
  monetize :price_cents
end
