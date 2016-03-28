include SessionsConcern

class TicketsController < ApplicationController

  def new
    @event = event_model.find(params[:event_id])
    @ticket = model.new
    @user = current_user
  end

  def create
    user = current_user
    ticket_option = ticket_option_model.find(ticket_params[:ticket_option_id])
    event = ticket_option.event

    ticket = model.new
    ticket.user = user
    ticket.ticket_option = ticket_option

    price = ticket_price_service.ticket_total_price(ticket)
    customer = users_service.find_or_create_customer(user, params[:stripeToken])
    description = "#{event.name} #{ticket_option.name} for #{user.first_name} #{user.last_name}"
    charge = charges_service.charge_customer(customer, price.cents, description)

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
    flash[:success] = "Your ticket was refunded. Sorry you can't make it! You will see this refund reflected on your card in 5-10 business days."
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

  def users_service
    UsersService
  end

  def charges_service
    ChargesService
  end

  def ticket_option_model
    TicketOption
  end

  def tickets_service
    TicketsService
  end

  def ticket_price_service
    TicketPriceService
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
