describe 'users/_event.html.haml' do
  fixtures(:events)
  fixtures(:tickets)

  describe 'basic form composition' do
    let(:event) { events(:salsa_party) }
    let(:ticket) { tickets(:crystals_ticket) }

    describe 'basic layout' do
      before do
        render partial: 'users/event', locals: {event: event}
      end

      it 'renders the Event name' do
        expect(rendered).to have_text(event.name)
      end

      it 'renders the Event start date (formatted)' do
        expect(rendered).to have_text(event.event_start.strftime('%A, %B %e, %Y'))
      end
    end

    describe 'when given an event with a ticket' do
      before do
        render partial: 'users/event', locals: {event: event, ticket: ticket}
      end

      it 'renders the purchased Ticket Option' do
        expect(rendered).to have_text(ticket.ticket_option.name)
      end

      it 'renders the name of the User for the purchased Ticket' do
        expect(rendered).to have_text("#{ticket.user.first_name} #{ticket.user.last_name}")
      end

      it 'renders a link the Ticket details' do
        expect(rendered).to have_link 'Details', ticket_path(ticket)
      end
    end

    describe 'when given an event without a ticket' do
      before do
        render partial: 'users/event', locals: {event: event}
      end

      it 'renders a link to buy a Ticket' do
        expect(rendered).to have_link 'Buy Ticket', event_path(event)
      end
    end
  end
end
