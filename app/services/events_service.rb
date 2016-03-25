module EventsService
  extend self

  def upcoming_events
    model.where('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now)
  end

  def model
    Event
  end
end
