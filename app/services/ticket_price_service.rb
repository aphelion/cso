module TicketPriceService
  extend self

  def event_purchase_base_price(event_purchase)
    ticket_price = event_purchase.ticket_purchase.product ? event_purchase.ticket_purchase.product.price : Money.new(0)
    addons_price = Money.new(0)
    event_purchase.addon_purchases.each do |addon_purchase|
      if ActiveRecord::Type::Boolean.new.type_cast_from_database(addon_purchase.purchase)
        addons_price += addon_purchase.product.price
      end
    end
    ticket_price + addons_price
  end

  def event_purchase_processing_fees(event_purchase)
    event_purchase_total_price(event_purchase) - event_purchase_base_price(event_purchase)
  end

  def event_purchase_total_price(event_purchase)
    return Money.new(0) unless event_purchase_base_price(event_purchase).cents > 0
    (event_purchase_base_price(event_purchase) + Money.new(30)) / (1 - 0.029)
  end
end
