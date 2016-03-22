describe 'users/tickets.html.haml' do
  fixtures(:events)
  let(:salsa_party) { events(:salsa_party) }
  let(:purchasable_events) { [salsa_party] }

  before do
    assign(:purchasable_events, purchasable_events)
    render
  end

  it 'renders a title' do
    expect(rendered).to have_text('Ticket')
  end

  it 'lists the purchasable event tickets' do
    purchasable_events.each do |event|
      event.tickets.each do |ticket|
        expect(rendered).to have_text(ticket.name)
      end
    end
  end

  it 'links to the purchase page for each purchasable event ticket' do
    purchasable_events.each do |event|
      event.tickets.each do |ticket|
        expect(rendered).to have_link 'Purchase', href: purchase_event_ticket_path(event, ticket)
      end
    end
  end
end
