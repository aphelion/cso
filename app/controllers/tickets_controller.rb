include SessionsConcern

class TicketsController < ApplicationController
  before_action :must_be_authenticated

  def my
    @upcoming_events = events_service.upcoming_events
  end

  def events_service
    EventsService
  end
end
