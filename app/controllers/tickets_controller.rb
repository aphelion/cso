class TicketsController < ApplicationController
  def index
    @event = event_model.find(params[:event_id])
    @tickets = model.find_by(event_id: params[:event_id])
  end

  def event_model
    Event
  end

  def model
    Ticket
  end
end
