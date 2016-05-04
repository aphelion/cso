class AdminController < ApplicationController
  include SessionsConcern
  before_action :must_be_admin

  def home
    @upcoming_events = events_service.upcoming_events
  end

  def events_service
    EventsService
  end
end
