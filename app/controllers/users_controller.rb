include SessionsConcern

class UsersController < ApplicationController
  before_action :must_be_authenticated, only: [:tickets]

  def tickets
    @purchasable_events = events_service.purchasable_events
  end

  def events_service
    EventsService
  end
end
