class TicketPurchasesController < ApplicationController

  def new
    @event = event_model.find(params[:event_id])
    @ticket_option = ticket_option_model.find(params[:ticket_option_id])
    @ticket_purchase = model.new
  end

  def create
    ticket_purchase = model.new
    ticket_purchase.event_id = params[:event_id]
    ticket_purchase.ticket_option_id = params[:ticket_option_id]
    ticket_purchase.user = current_user
    ticket_purchase.save
    redirect_to confirmation_event_path(params[:event_id])
  end

  def show
    ticket_purchase = model.find(params[:id])
    head :forbidden unless ticket_purchase.user == current_user
    @event = ticket_purchase.event
    @user = current_user
  end

  def model
    TicketPurchase
  end

  def event_model
    Event
  end

  def ticket_option_model
    TicketOption
  end
end
