describe 'tickets/_ticket_form.html.haml' do
  fixtures(:tickets)

  let(:ticket) { tickets(:crystals_ticket) }

  before do
    render partial: 'tickets/ticket', locals: {ticket: ticket}
  end

  it 'renders the purchased Ticket Option' do
    expect(rendered).to have_text(ticket.ticket_option.name)
  end

  it 'renders the name of the User for the purchased Ticket' do
    expect(rendered).to have_text("#{ticket.user.first_name} #{ticket.user.last_name}")
  end
end
