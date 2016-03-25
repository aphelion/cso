include SessionsConcern

class UsersController < ApplicationController
  before_action :must_be_authenticated, only: [:tickets]

  def tickets
    @upcoming_events = events_service.upcoming_events
  end

  def events_service
    EventsService
  end
end
