include SessionsConcern

class TicketsController < ApplicationController

  def new
    @event = event_model.find(params[:event_id])
    @ticket = model.new
    @user = current_user
  end

  def create
    event = event_model.find(params[:event_id])
    ticket_option = ticket_option_model.find(ticket_params[:ticket_option_id])

    ticket = model.new
    ticket.user = current_user
    ticket.ticket_option_id = ticket_params[:ticket_option_id]

    customer = customer_service.create(
        description: "#{current_user.first_name} #{current_user.last_name}",
        email: current_user.email,
        source: params[:stripeToken]
    )

    stripe_charge = charge_service.create(
        customer: customer.id,
        amount: ticket_service.ticket_total_price(ticket).cents,
        description: "#{event.name} #{ticket_option.name} for #{current_user.first_name} #{current_user.last_name}",
        currency: 'USD'
    )
    charge = charge_model.create(
        charge_id: stripe_charge.id,
        processor: 'stripe'
    )

    ticket.charge = charge
    if ticket.save
      flash[:success] = "Thanks for buying a ticket! See you at the #{event.name}!"
      redirect_to user_tickets_path
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

    charge = ticket.charge
    refund_service.create(
        charge: charge.charge_id,
        reason: 'requested_by_customer'
    )
    ticket.destroy
    flash[:success] = "Your ticket was refunded. Sorry you can't make it!"
    redirect_to user_tickets_path
  rescue Stripe::StripeError => e
    flash[:error] = e.message
    redirect_to :back
  end

  def calculate
    @event = event_model.find(params[:event_id])
    @ticket = model.new(ticket_params)
    @user = current_user
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

  def ticket_service
    TicketsService
  end

  def customer_service
    Stripe::Customer
  end

  def charge_service
    Stripe::Charge
  end

  def refund_service
    Stripe::Refund
  end

  def charge_model
    Charge
  end

  private
  def ticket_params
    params.require(:ticket).permit(:ticket_option_id)
  end
end
