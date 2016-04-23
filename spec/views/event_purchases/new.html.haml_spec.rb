describe 'event_purchases/new.html.haml' do
  fixtures(:events)
  let(:event) { events(:bachata_party) }
  let(:event_purchase) { EventPurchase.new }

  before do
    event_purchase.event = event
    assign(:event_purchase, event_purchase)
    render
  end

  it 'renders the Event name' do
    expect(rendered).to have_text(event.name)
  end

  it 'renders an Event Purchase form' do
    expect(view).to have_rendered(partial: 'event_purchases/_form', locals: {event_purchase: event_purchase})
  end
end
