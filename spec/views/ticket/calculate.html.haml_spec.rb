describe 'tickets/calculate.html.haml' do
  fixtures(:events)
  fixtures(:users)

  let(:event) { events(:bachata_party) }
  let(:ticket) { Ticket.new }
  let(:user) { users(:young) }

  before do
    ticket.ticket_option = event.ticket_options.first

    assign(:event, event)
    assign(:ticket, ticket)
    assign(:user, user)

    render template: 'tickets/calculate'
  end

  it 'renders a Ticket purchase form' do
    expect(view).to have_rendered(partial: 'tickets/_purchase_form', locals: {event: event, ticket: ticket, user: user})
  end
end
