module TicketsHelper
  def ticket_for_event_for_current_user(event)
    tickets_service.ticket_for_event_for_user(current_user, event)
  end

  def ticket_base_price(ticket)
    tickets_service.ticket_base_price(ticket)
  end

  def ticket_processing_fees(ticket)
    tickets_service.ticket_processing_fees(ticket)
  end

  def ticket_total_price(ticket)
    tickets_service.ticket_total_price(ticket)
  end

  def tickets_service
    TicketsService
  end
end
