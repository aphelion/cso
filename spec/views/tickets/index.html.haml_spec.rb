describe 'tickets/index.html.haml' do
  fixtures(:tickets)
  fixtures(:events)
  let(:all_tickets) { [tickets(:bachata_party_full_pass), tickets(:bachata_party_night_pass)] }
  let(:event) { events(:bachata_party) }

  before do
    assign(:tickets, all_tickets)
    assign(:event, event)
    render
  end

  it 'renders all Tickets in a table' do
    expect(view).to have_rendered(partial: 'tickets/_table', locals: {tickets: all_tickets})
  end

  it 'links to the new Ticket page' do
    assert_select 'a', 'New Event Ticket', href: new_event_ticket_path(event)
  end
end
