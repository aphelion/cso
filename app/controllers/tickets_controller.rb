class TicketsController < ApplicationController
  def index
    @event = event_model.find(params[:event_id])
    @tickets = @event.tickets
  end

  def new
    @event = event_model.find(params[:event_id])
    @ticket = model.new
  end

  def edit
    @ticket = model.find(params[:id])
  end

  def create
    ticket = model.new(event_params)
    ticket.event_id = params[:event_id]
    if ticket.save
      redirect_to event_tickets_path(params[:event_id])
    else
      @ticket = ticket
      render :new
    end
  end

  def update
    ticket = model.find(params[:id])
    if ticket.update(event_params)
      redirect_to event_tickets_path(params[:event_id])
    else
      @ticket = ticket
      render :edit
    end
  end

  def event_model
    Event
  end

  def model
    Ticket
  end

  private
  def event_params
    params.require(:ticket).permit(:name)
  end
end
