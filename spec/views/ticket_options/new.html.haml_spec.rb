describe 'ticket_options/new.html.haml' do
  fixtures(:events)
  let(:event) { events(:bachata_party) }
  let(:ticket_option) { TicketOption.new }

  before do
    assign(:event, event)
    assign(:ticket_option, ticket_option)
    render
  end

  it 'renders a form for the new Ticket Option' do
    expect(view).to have_rendered(
                        partial: 'form',
                        locals: {event: event, ticket_option: ticket_option, cancel_path: event_ticket_options_path(event)}
                    )
  end
end
