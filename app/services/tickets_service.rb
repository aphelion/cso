module TicketsService
  extend self

  def ticket_for_event_for_user(user, event)
    ticket_model.where(user: user).joins(:ticket_option).where(ticket_options: {event_id: event}).first
  end

  def ticket_model
    Ticket
  end
end
