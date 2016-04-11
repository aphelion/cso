module EventPurchaseHelper

  def event_purchase_for_event_for_current_user(event)
    service.find_by_event_and_user(event, current_user)
  end

  def service
    EventPurchasesService
  end
end
