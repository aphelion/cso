module TicketsHelper
  def ticket_for_event_for_current_user(event)
    tickets_service.ticket_for_event_for_user(current_user, event)
  end

  def ticket_base_price(ticket)
    ticket.ticket_option ? ticket.ticket_option.price : Money.new(0)
  end

  def ticket_processing_fees(ticket)
    ticket_total_price(ticket) - ticket_base_price(ticket)
  end

  def ticket_total_price(ticket)
    return Money.new(0) unless ticket_base_price(ticket).cents > 0
    (ticket_base_price(ticket) + Money.new(30)) / (1 - 0.029)
  end

  def tickets_service
    TicketsService
  end
end
