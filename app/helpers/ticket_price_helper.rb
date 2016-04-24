module TicketPriceHelper
  def event_purchase_base_price(ticket)
    ticket_price_service.event_purchase_base_price(ticket)
  end

  def event_purchase_processing_fees(ticket)
    ticket_price_service.event_purchase_processing_fees(ticket)
  end

  def event_purchase_total_price(ticket)
    ticket_price_service.event_purchase_total_price(ticket)
  end

  def ticket_price_service
    TicketPriceService
  end
end
