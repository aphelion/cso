class TicketsController < ApplicationController
  include SessionsConcern
  before_action :must_be_authenticated

  def my
    @upcoming_events = events_service.upcoming_events
    @past_event_event_purchases = event_purchases_service.past_event_event_purchases(current_user)
  end

  def events_service
    EventsService
  end

  def event_purchases_service
    EventPurchasesService
  end
end
