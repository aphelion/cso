module TicketsHelper
  def ticket_for_event_for_current_user(event)
    tickets_service.ticket_for_event_for_user(current_user, event)
  end

  def tickets_service
    TicketsService
  end
end
