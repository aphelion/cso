include SessionsConcern

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:tickets]

  def tickets
    @purchasable_events = events_service.purchasable_events
  end

  def events_service
    EventsService
  end
end
