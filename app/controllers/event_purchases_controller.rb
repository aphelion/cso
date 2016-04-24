class EventPurchasesController < ApplicationController
  include SessionsConcern
  before_action :must_be_authenticated

  def new
    @user = current_user
    @event_purchase = event_purchase_model.new
    event = event_model.find(params[:event_id])
    @event_purchase.event = event
    @event_purchase.ticket_purchase = ProductPurchase.new
    event.addons.each do |addon|
      @event_purchase.addon_purchases << ProductPurchase.new(product: addon, quantity: 0)
    end
  end

  def show
    @event_purchase = event_purchase_model.find(params[:id])
    head :forbidden unless @event_purchase.user == current_user
  end

  def calculate
    @user = current_user
    @event_purchase = event_purchase_model.new(event_purchase_params)
    event = event_model.find(params[:event_id])
    @event_purchase.event = event
  end

  def create
    user = current_user
    event_purchase = event_purchase_model.new(event_purchase_params)
    event_purchase.event = event_model.find(params[:event_id])
    event_purchase.user = user
    price = event_purchase_price_service.event_purchase_total_price(event_purchase)
    customer = users_service.find_or_create_customer(user, params[:stripeToken])
    description = "#{event_purchase.event.name} #{event_purchase.ticket_purchase.product.name} for #{user.first_name} #{user.last_name}"
    charge = charges_service.charge_customer(customer, price.cents, description)

    event_purchase.ticket_purchase.charge = charge
    event_purchase.addon_purchases.each do |addon_purchase|
      addon_purchase.charge = charge
    end

    event_purchase.save

    flash[:success] = "Thanks for buying a ticket! See you at the #{event_purchase.event.name}!"
    redirect_to my_tickets_path
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

  private
  def event_purchase_params
    params.require(:event_purchase).permit(
        ticket_purchase_attributes: [:quantity, :product_id],
        addon_purchases_attributes: [[:quantity, :product_id]]
    )
  end
end
