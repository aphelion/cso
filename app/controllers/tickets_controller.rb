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
      flash[:error] = ticket.errors.full_messages.join(' ')
      redirect_to :back
    end
  end

  def show
    @ticket = model.find(params[:id])
    head :forbidden unless @ticket.user == current_user
  end

  def destroy
    ticket = model.find(params[:id])
    head :forbidden and return unless ticket.user == current_user

    ticket.destroy
    flash[:success] = 'Your ticket has been refunded.'
    redirect_to user_tickets_path
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
