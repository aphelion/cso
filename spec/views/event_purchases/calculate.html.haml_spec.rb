describe 'event_purchases/calculate.html.haml' do
  fixtures(:events)
  fixtures(:users)
  let(:event) { events(:bachata_party) }
  let(:event_purchase) { EventPurchase.new }
  let(:user) { users(:young) }

  before do
    event_purchase.event = event
    event_purchase.ticket_purchase = ProductPurchase.new
    assign(:event_purchase, event_purchase)
    assign(:user, user)
    render
  end

  it 'renders an Event Purchase form' do
    expect(view).to have_rendered(partial: 'event_purchases/_form', locals: {event_purchase: event_purchase, user: user})
  end
end
