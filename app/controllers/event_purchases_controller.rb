class EventPurchasesController < ApplicationController
  include SessionsConcern
  before_action :must_be_authenticated

  def new
    event = event_model.find(params[:event_id])
    @event_purchase = event_purchase_model.new
    @event_purchase.event = event
  end

  def event_model
    Event
  end

  def event_purchase_model
    EventPurchase
  end
end
