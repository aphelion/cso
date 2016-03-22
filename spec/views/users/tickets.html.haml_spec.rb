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
