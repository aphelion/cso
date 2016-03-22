describe 'ticket_options/index.html.haml' do
  fixtures(:ticket_options)
  fixtures(:events)
  let(:all_tickets) { [ticket_options(:bachata_party_full_pass), ticket_options(:bachata_party_night_pass)] }
  let(:event) { events(:bachata_party) }

  before do
    assign(:ticket_options, all_tickets)
    assign(:event, event)
    render
  end

  it 'renders a title indicating the Event' do
    expect(rendered).to have_text("#{event.name} Ticket Options")
  end

  it 'renders all Tickets in a table' do
    expect(view).to have_rendered(partial: 'ticket_options/_table', locals: {ticket_options: all_tickets})
  end

  it 'links to the new Ticket Option page' do
    assert_select 'a', 'New Ticket Option', href: new_event_ticket_option_path(event)
  end
end
