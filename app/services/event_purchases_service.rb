module EventPurchasesService
  extend self

  def find_by_event_and_user(event, user)
    model.find_by(event: event, user: user)
  end

  def past_event_event_purchases(user)
    model.where(user: user)
        .joins(:event)
        .where('events.sale_end < ?', DateTime.now)
        .order('events.event_end DESC')
  end

  def model
    EventPurchase
  end
end
