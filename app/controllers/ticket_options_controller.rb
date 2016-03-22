class TicketOptionsController < ApplicationController
  def index
    @event = event_model.find(params[:event_id])
    @ticket_options = @event.ticket_options
  end

  def new
    @event = event_model.find(params[:event_id])
    @ticket_option = model.new
  end

  def edit
    @ticket_option = model.find(params[:id])
  end

  def create
    ticket_option = model.new(event_params)
    ticket_option.event_id = params[:event_id]
    if ticket_option.save
      redirect_to event_ticket_options_path(params[:event_id])
    else
      @ticket_option = ticket_option
      render :new
    end
  end

  def update
    ticket_option = model.find(params[:id])
    if ticket_option.update(event_params)
      redirect_to event_ticket_options_path(params[:event_id])
    else
      @ticket_option = ticket_option
      render :edit
    end
  end

  def event_model
    Event
  end

  def model
    TicketOption
  end

  private
  def event_params
    params.require(:ticket_option).permit(:name)
  end
end
