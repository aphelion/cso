module EventPurchasePriceHelper
  def event_purchase_base_price(ticket)
    event_purchase_price_service.event_purchase_base_price(ticket)
  end

  def event_purchase_processing_fees(ticket)
    event_purchase_price_service.event_purchase_processing_fees(ticket)
  end

  def event_purchase_total_price(ticket)
    event_purchase_price_service.event_purchase_total_price(ticket)
  end

  def purchased_event_purchase_base_price(ticket)
    event_purchase_price_service.purchased_event_purchase_base_price(ticket)
  end

  def purchased_event_purchase_processing_fees(ticket)
    event_purchase_price_service.purchased_event_purchase_processing_fees(ticket)
  end

  def purchased_event_purchase_total_price(ticket)
    event_purchase_price_service.purchased_event_purchase_total_price(ticket)
  end

  def event_purchase_price_service
    EventPurchasePriceService
  end
end
