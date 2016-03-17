describe 'tickets/new.html.haml' do
  fixtures(:events)
  let(:event) { events(:bachata_party) }
  let(:ticket) { Ticket.new }

  before do
    assign(:event, event)
    assign(:ticket, ticket)
    render
  end

  it 'renders a form for the new Ticket' do
    expect(view).to have_rendered(
                        partial: 'form',
                        locals: {event: event, ticket: ticket, cancel_path: event_tickets_path(event)}
                    )
  end
end
