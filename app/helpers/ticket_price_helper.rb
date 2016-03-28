module TicketPriceHelper
  def ticket_base_price(ticket)
    ticket_price_service.ticket_base_price(ticket)
  end

  def ticket_processing_fees(ticket)
    ticket_price_service.ticket_processing_fees(ticket)
  end

  def ticket_total_price(ticket)
    ticket_price_service.ticket_total_price(ticket)
  end

  def ticket_price_service
    TicketPriceService
  end
end
