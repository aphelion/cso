include SessionsConcern

class UsersController < ApplicationController
  before_action :must_be_authenticated, only: [:tickets]

  def tickets
    @upcoming_purchased_tickets = events_service.upcoming_purchased_tickets(current_user)
    @purchasable_events = events_service.purchasable_events(current_user)
  end

  def events_service
    EventsService
  end
end
