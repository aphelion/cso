module EventsService
  extend self

  def upcoming_events
    model.where('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now).order(event_start: :asc)
  end

  def model
    Event
  end
end
