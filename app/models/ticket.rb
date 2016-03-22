class Ticket < ActiveRecord::Base
  belongs_to :ticket_option
  has_one :event, through: :ticket_option
  belongs_to :user
end
