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
    end
  end

  it 'lists the purchasable Event Tickets' do
    purchasable_events.each do |event|
      event.ticket_options.each do |ticket_option|
        expect(rendered).to have_text(ticket_option.name)
      end
    end
  end

  it 'links to the new Ticket page for each purchasable Event Ticket Option' do
    purchasable_events.each do |event|
      event.ticket_options.each do |ticket_option|
        expect(rendered).to have_link 'Purchase', href: new_event_ticket_option_ticket_path(event, ticket_option)
      end
    end
  end
end
