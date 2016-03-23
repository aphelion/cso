include SessionsConcern

class TicketsController < ApplicationController

  def new
    @event = event_model.find(params[:event_id])
    @ticket_option = ticket_option_model.find(params[:ticket_option_id])
    @ticket = model.new
  end

  def create
    ticket = model.new
    ticket.ticket_option_id = params[:ticket_option_id]
    ticket.user = current_user
    if ticket.save
      redirect_to ticket_path(ticket.id)
    else
      redirect_to :back
    end
  end

  def show
    @ticket = model.find(params[:id])
    head :forbidden unless @ticket.user == current_user
  end

  def model
    Ticket
  end

  def event_model
    Event
  end

  def ticket_option_model
    TicketOption
  end
end
