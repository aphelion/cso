module EventPurchasesService
  extend self

  def find_by_event_and_user(event, user)
    model.find_by(event: event, user: user)
  end

  def model
    EventPurchase
  end
end
