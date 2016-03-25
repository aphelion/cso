describe 'users/tickets.html.haml' do
  fixtures(:events)
  fixtures(:tickets)
  let(:salsa_party) { events(:salsa_party) }
  let(:crystals_ticket) { tickets(:crystals_ticket) }
  let(:purchasable_events) { [salsa_party] }
  let(:upcoming_purchased_tickets) { [crystals_ticket] }

  before do
    assign(:upcoming_purchased_tickets, upcoming_purchased_tickets)
    assign(:purchasable_events, purchasable_events)
    render
  end

  it 'renders a title' do
    expect(rendered).to have_text('Ticket')
  end

  it 'lists the upcoming purchased Event Tickets' do
    upcoming_purchased_tickets.each do |ticket|
      expect(rendered).to have_text(ticket.event.name)
      expect(rendered).to have_text(ticket.ticket_option.name)
      expect(rendered).to have_link('Details', ticket_path(ticket))
    end
  end

  it 'lists the purchasable Events' do
    purchasable_events.each do |event|
      expect(rendered).to have_text(event.name)
    end
  end

  it 'links to the Event page for each purchasable Event' do
    purchasable_events.each do |event|
      expect(rendered).to have_link 'Purchase', href: event_path(event)
    end
  end
end
