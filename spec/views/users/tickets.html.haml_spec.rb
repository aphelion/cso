describe 'users/tickets.html.haml' do
  fixtures(:events)
  fixtures(:tickets)
  let(:bachata_party) { events(:bachata_party) }
  let(:crystals_ticket) { tickets(:crystals_ticket) }
  let(:purchasable_events) { [bachata_party] }
  let(:upcoming_purchased_tickets) { [crystals_ticket] }

  before do
    assign(:upcoming_purchased_tickets, upcoming_purchased_tickets)
    assign(:purchasable_events, purchasable_events)
    render
  end

  it 'renders a title' do
    expect(rendered).to have_text('Ticket')
  end

  it 'renders the upcoming purchased Event Tickets' do
    upcoming_purchased_tickets.each do |ticket|
      expect(view).to have_rendered(partial: 'users/_event', locals: {event: ticket.event, ticket: ticket})
    end
  end

  it 'renders the purchasable Events' do
    purchasable_events.each do |event|
      expect(view).to have_rendered(partial: 'users/_event', locals: {event: event})
    end
  end
end
