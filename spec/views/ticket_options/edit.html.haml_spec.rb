describe 'ticket_options/edit.html.haml' do
  fixtures(:ticket_options)
  let(:ticket_option) { ticket_options(:bachata_party_full_pass) }

  before do
    assign(:ticket_option, ticket_option)
    render
  end

  it 'renders a form for the Event' do
    expect(view).to have_rendered(partial: 'form', locals: {ticket_option: ticket_option, cancel_path: event_ticket_options_path(ticket_option.event)})
  end
end
