describe 'tickets/new.html.haml' do
  fixtures(:events)
  fixtures(:users)

  let(:event) { events(:bachata_party) }
  let(:ticket) { Ticket.new }
  let(:user) { users(:young) }

  before do
    assign(:event, event)
    assign(:ticket, ticket)
    assign(:user, user)

    render template: 'tickets/new'
  end

  it 'renders a page title' do
    expect(rendered).to have_text "Purchase a Ticket for #{event.name}"
  end

  it 'renders a Ticket purchase form' do
    expect(view).to have_rendered(partial: 'tickets/_purchase_form', locals: {event: event, ticket: ticket, user: user})
  end
end
