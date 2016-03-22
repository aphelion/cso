describe 'ticket_options/table/_row.html.haml' do
  fixtures(:ticket_options)
  let(:ticket_option) { ticket_options(:bachata_party_full_pass) }

  before do
    render partial: 'ticket_options/table/row', locals: {ticket_option: ticket_option}
  end

  it 'shows the Ticket Option name' do
    assert_select 'tr td:nth-child(1)', {text: ticket_option.name}
  end

  it 'renders a link to the Ticket Option edit page' do
    assert_select 'tr td:nth-child(2) a[href=?]', edit_event_ticket_option_path(ticket_option.event, ticket_option), 'Edit'
  end
end
