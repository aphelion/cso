module EventsService
  extend self

  def purchasable_events
    model.where('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now)
  end

  def model
    Event
  end
end
