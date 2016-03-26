describe 'users/_event.html.haml' do
  fixtures(:events)
  fixtures(:tickets)

  describe 'basic form composition' do
    let(:event) { events(:salsa_party) }
    let(:ticket) { tickets(:crystals_ticket) }

    describe 'basic layout' do
      before do
        expect(view).to receive(:ticket_for_event_for_current_user).and_return(nil)
        render partial: 'users/event', locals: {event: event}
      end

      it 'renders the Event name' do
        expect(rendered).to have_text(event.name)
      end

      it 'renders the Event description' do
        expect(rendered).to have_text(event.description)
      end

      it 'renders the Event start date (formatted)' do
        expect(rendered).to have_text(event.event_start.strftime('%A, %B %e, %Y'))
      end
    end

    describe 'when given an event with a ticket' do
      before do
        expect(view).to receive(:ticket_for_event_for_current_user).and_return(ticket)
        render partial: 'users/event', locals: {event: event}
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

    describe 'when the current User does not have a Ticket for the given Event' do
      before do
        expect(view).to receive(:ticket_for_event_for_current_user).and_return(nil)
        render partial: 'users/event', locals: {event: event}
      end

      it 'renders a link to buy a Ticket' do
        expect(rendered).to have_link 'Buy Ticket', href: new_event_ticket_path(event)
      end
    end
  end
end
