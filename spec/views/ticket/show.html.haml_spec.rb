include MoneyRails::ActionViewExtension

describe 'tickets/show.html.haml' do
  fixtures(:tickets)
  let(:ticket) { tickets(:crystals_ticket) }

  before do
    assign(:ticket, ticket)
    render
  end

  it 'greets the User by name' do
    expect(rendered).to have_text(ticket.user.first_name)
  end

  it 'reminds the User which Ticket Option they purchased' do
    expect(rendered).to have_text(ticket.ticket_option.name)
  end

  it 'indicates which Event this Ticket is for' do
    expect(rendered).to have_text(ticket.event.name)
  end

  it 'renders the Ticket partial' do
    expect(view).to have_rendered(partial: 'tickets/_ticket', locals: {ticket: ticket})
  end

  it 'renders the Ticket price breakdown' do
    expect(view).to have_rendered(partial: 'tickets/_ticket_price_breakdown', locals: {event: ticket.event, ticket: ticket})
  end

  it 'renders a link to refund the Ticket' do
    assert_select 'a[href=?][data-method=?]', ticket_path(ticket), 'delete', text: 'Refund Ticket'
  end
end
