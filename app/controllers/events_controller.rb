class EventsController < ApplicationController
  include SessionsConcern

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

  def model
    Event
  end

  private
  def event_params
    params.require(:event).permit(:name, :event_start, :event_end, :sale_start, :sale_end)
  end
end
