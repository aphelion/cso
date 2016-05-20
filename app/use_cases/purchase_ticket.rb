module PurchaseTicket
  extend self

  def perform(user, event_id, stripe_token, event_purchase_params)
      event_purchase = build_event_purchase(event_id, event_purchase_params, user)
      price = event_purchase_price_service.event_purchase_total_price(event_purchase)
      customer = users_service.find_or_create_customer(user, stripe_token)
      description = "#{event_purchase.event.name} #{event_purchase.ticket_purchase.product.name} for #{user.full_name}"
      charge = charges_service.charge_customer(customer, price.cents, description)

      event_purchase.ticket_purchase.charge = charge
      add_charge_to_addons(charge, event_purchase)

      event_purchase.save
      event_purchase
  end

  def build_event_purchase(event_id, event_purchase_params, user)
    event_purchase = event_purchase_model.new(event_purchase_params)
    event_purchase.event = event_model.find(event_id)
    event_purchase.user = user
    event_purchase
  end

  def add_charge_to_addons(charge, event_purchase)
    event_purchase.addon_purchases.each do |addon_purchase|
      addon_purchase.charge = charge
    end
  end

  def event_model
    Event
  end

  def event_purchase_model
    EventPurchase
  end

  def charges_service
    ChargesService
  end

  def event_purchase_price_service
    EventPurchasePriceService
  end

  def users_service
    UsersService
  end
end