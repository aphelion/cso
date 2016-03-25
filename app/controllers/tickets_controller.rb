include SessionsConcern

class TicketsController < ApplicationController

  def new
    @event = event_model.find(params[:event_id])
    @ticket_option = ticket_option_model.find(params[:ticket_option_id])
    @user = current_user
    @ticket = model.new
  end

  def create
    event = event_model.find(params[:event_id])
    ticket_option = ticket_option_model.find(params[:ticket_option_id])

    customer = customer_service.create(
        description: "#{current_user.first_name} #{current_user.last_name}",
        email: current_user.email,
        source: params[:stripeToken]
    )

    stripe_charge = charge_service.create(
        customer: customer.id,
        amount: ticket_option.price_cents,
        description: "#{event.name} #{ticket_option.name} for #{current_user.first_name} #{current_user.last_name}",
        currency: 'USD'
    )
    charge = charge_model.create(charge_id: stripe_charge.id, processor: 'stripe')
    ticket = model.new
    ticket.user = current_user
    ticket.charge = charge
    ticket.ticket_option_id = params[:ticket_option_id]
    if ticket.save
      redirect_to ticket_path(ticket.id)
    else
      flash[:error] = ticket.errors.full_messages.join(' ')
      redirect_to :back
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end

  def show
    @ticket = model.find(params[:id])
    head :forbidden unless @ticket.user == current_user
  end

  def destroy
    ticket = model.find(params[:id])
    head :forbidden and return unless ticket.user == current_user

    ticket.destroy
    flash[:success] = 'Your ticket was refunded.'
    redirect_to user_tickets_path
  rescue Stripe::StripeError => e
    flash[:error] = e.message
    redirect_to :back
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

  def customer_service
    Stripe::Customer
  end

  def charge_service
    Stripe::Charge
  end

  def charge_model
    Charge
  end
end
