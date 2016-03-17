class TicketsController < ApplicationController
  def index
    @event = event_model.find(params[:event_id])
    @tickets = @event.tickets
  end

  def new
    @ticket = model.new
  end

  def event_model
    Event
  end

  def model
    Ticket
  end
end
