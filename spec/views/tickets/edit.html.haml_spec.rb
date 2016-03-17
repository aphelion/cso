describe 'tickets/edit.html.haml' do
  fixtures(:tickets)
  let(:ticket) { tickets(:bachata_party_full_pass) }

  before do
    assign(:ticket, ticket)
    render
  end

  it 'renders a form for the Event' do
    expect(view).to have_rendered(partial: 'form', locals: {ticket: ticket, cancel_path: event_tickets_path(ticket.event)})
  end
end
