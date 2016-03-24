describe 'events/show.html.haml' do
  fixtures(:tickets)
  let(:ticket) { tickets(:crystals_ticket) }
  let(:user) { ticket.user }
  let(:event) { ticket.event }

  before do
    assign(:event, event)
  end

  it 'renders the Event name' do
    render
    expect(rendered).to have_text(event.name)
  end

  context 'when the User has a ticket for this Event' do
    before do
      allow(view).to receive(:ticket_for_event_for_current_user).with(event).and_return(ticket)
      render
    end

    it 'displays a link to view the Ticket' do
      expect(rendered).to have_link 'View Ticket', href: ticket_path(ticket)
    end
  end

  context 'when the User does not have a ticket for this Event' do
    before do
      allow(view).to receive(:ticket_for_event_for_current_user).with(event).and_return(nil)
      render
    end

    it 'displays a purchase link for each Ticket Option' do
      event.ticket_options.each do |ticket_option|
        expect(rendered).to have_text ticket_option.name
        expect(rendered).to have_link 'Purchase', href: new_event_ticket_option_ticket_path(event, ticket_option)
      end
    end
  end
end
