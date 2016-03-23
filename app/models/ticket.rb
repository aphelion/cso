class Ticket < ActiveRecord::Base
  belongs_to :ticket_option
  has_one :event, through: :ticket_option
  belongs_to :user

  validate :one_ticket_per_user_per_event

  def one_ticket_per_user_per_event
    errors.add(:base, 'You may only have one ticket for each event.') if user.reload.tickets.any? do |ticket|
      ticket.event == ticket_option.event
    end
  end
end