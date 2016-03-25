describe 'tickets/show.html.haml' do
  fixtures(:tickets)
  let(:ticket) { tickets(:crystals_ticket) }

  before do
    assign(:ticket, ticket)
    render
  end

  it 'tells the user they have a Ticket' do
    expect(rendered).to have_text(ticket.event.name)
    expect(rendered).to have_text(ticket.ticket_option.name)
    expect(rendered).to have_text(ticket.user.first_name)
  end

  it 'renders a link to refund the Ticket' do
    assert_select 'a[href=?][data-method=?]', ticket_path(ticket), 'delete', text: 'Refund Ticket'
  end
end
