describe 'tickets/table/_row.html.haml' do
  fixtures(:tickets)
  let(:ticket) { tickets(:bachata_party_full_pass) }

  before do
    render partial: 'tickets/table/row', locals: {ticket: ticket}
  end

  it 'shows the Ticket name' do
    assert_select 'tr td:nth-child(1)', {text: ticket.name}
  end

  it 'renders a link to the Ticket edit page' do
    assert_select 'tr td:nth-child(2) a[href=?]', edit_event_ticket_path(ticket.event, ticket), 'Edit'
  end
end
