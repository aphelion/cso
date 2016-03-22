include SessionsConcern

class EventsController < ApplicationController
  before_action :admin_user

  def index
    @events = model.all
  end

  def new
    @event = model.new
  end

  def create
    event = model.new(event_params)
    if event.save
      redirect_to events_path
    else
      @event = event
      render :new
    end
  end

  def edit
    @event = model.find(params[:id])
  end

  def update
    @event = model.find(params[:id])
    redirect_to @event.update(event_params) ? events_path : edit_event_path(params[:id])
  end

  def confirmation
    @event = model.find(params[:id])
    @user = current_user
    ticket_purchase = ticket_purchase_model.find_by(event: @event, user: @user)

    head :not_found unless ticket_purchase
  end

  def model
    Event
  end

  def ticket_purchase_model
    TicketPurchase
  end

  private
  def event_params
    params.require(:event).permit(:name, :event_start, :event_end, :sale_start, :sale_end)
  end
end
