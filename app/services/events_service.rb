module EventsService
  extend self

  def upcoming_events
    model.where('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now)
  end

  def upcoming_purchased_tickets(user)
    ticket_model.where(user: user).joins(:ticket_option).where(ticket_options: {event_id: upcoming_events})
  end

  def purchasable_events(user)
    upcoming_events.joins(:ticket_options).distinct.where.not(id: user.tickets.map(&:event).map(&:id))
  end

  def model
    Event
  end

  def ticket_model
    Ticket
  end
end
