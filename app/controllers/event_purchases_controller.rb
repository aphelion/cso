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
      @event_purchase.addon_purchases << ProductPurchase.new(product: addon)
    end
  end

  def calculate
    @user = current_user
    @event_purchase = event_purchase_model.new(event_purchase_params)
    event = event_model.find(params[:event_id])
    @event_purchase.event = event
  end

  def event_model
    Event
  end

  def event_purchase_model
    EventPurchase
  end

  private
  def event_purchase_params
    params.require(:event_purchase).permit(
        ticket_purchase_attributes: [:product_id],
        addon_purchases_attributes: [[:purchase, :product_id]]
    )
  end
end
