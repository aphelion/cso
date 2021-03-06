class EventPurchasesController < ApplicationController
  include SessionsConcern
  before_action :must_be_authenticated
  layout false, only: [:calculate_new, :calculate_edit]

  def new
    @user = current_user
    @event_purchase = event_purchase_model.new
    event = event_model.find(params[:event_id])
    @event_purchase.event = event
    @event_purchase.ticket_purchase = ProductPurchase.new
  end

  def show
    @event_purchase = event_purchase_model.find(params[:id])
    head :forbidden unless @event_purchase.user == current_user
  end

  def calculate_new
    @user = current_user
    @event_purchase = event_purchase_model.new(event_purchase_params)
    event = event_model.find(params[:event_id])
    @event_purchase.event = event
    @event_purchase.addon_purchases << ProductPurchase.new(new_addon_params) if new_addon_params
  end

  def create
    user = current_user
    event_purchase = event_purchase_model.new(event_purchase_params)
    event_purchase.event = event_model.find(params[:event_id])
    event_purchase.user = user
    price = event_purchase_price_service.event_purchase_total_price(event_purchase)
    customer = users_service.find_or_create_customer(user, params[:stripeToken])
    description = "#{event_purchase.event.name} #{event_purchase.ticket_purchase.product.name} for #{user.full_name}"
    charge = charges_service.charge_customer(customer, price.cents, description)

    event_purchase.ticket_purchase.charge = charge
    event_purchase.addon_purchases.each do |addon_purchase|
      addon_purchase.charge = charge
    end

    event_purchase.save

    flash[:success] = "Thanks for buying a ticket! See you at the #{event_purchase.event.name}!"
    redirect_to my_tickets_path
  end

  def calculate_edit
    @user = current_user
    @event_purchase = event_purchase_model.find(params[:id])
    @event_purchase.assign_attributes(event_purchase_params)
    @event_purchase.association(:addon_purchases).add_to_target(ProductPurchase.new(new_addon_params)) if new_addon_params
  end

  def update
    user = current_user
    event_purchase = event_purchase_model.find(params[:id])
    event_purchase.assign_attributes(event_purchase_params)

    price = event_purchase_price_service.event_purchase_total_price(event_purchase)
    customer = users_service.find_or_create_customer(user, params[:stripeToken])
    description = "#{event_purchase.event.name} Ticket Addons for #{user.full_name}"
    charge = charges_service.charge_customer(customer, price.cents, description)

    event_purchase.addon_purchases.each do |addon_purchase|
      addon_purchase.charge = charge if addon_purchase.charge.nil?
    end

    event_purchase.save

    flash[:success] = "Thanks for buying some extra ticket addons! See you at the #{event_purchase.event.name}!"
    redirect_to my_tickets_path
  end

  def edit
    @event_purchase = event_purchase_model.find(params[:id])
    head :forbidden unless @event_purchase.user == current_user
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
        addon_purchases_attributes: [
            :quantity,
            :product_id,
            product_purchase_option_choices_attributes: [
                :option,
                :choice
            ]
        ]
    )
  end

  def new_addon_params
    params.require(:new_addon).permit(
        :quantity,
        :product_id,
        product_purchase_option_choices_attributes: [
            :option,
            :choice
        ]
    ) if params[:new_addon]
  end
end
