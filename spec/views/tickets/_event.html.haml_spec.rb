describe 'users/_event.html.haml' do
  fixtures(:events)
  fixtures(:event_purchases)

  describe 'basic form composition' do
    let(:event) { events(:salsa_party) }
    let(:event_purchase) { event_purchases(:crystals_salsa_party_purchase) }

    describe 'basic layout' do
      before do
        expect(view).to receive(:event_purchase_for_event_for_current_user).and_return(nil)
        render partial: 'tickets/event', locals: {event: event}
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
        expect(view).to receive(:event_purchase_for_event_for_current_user).and_return(event_purchase)
        render partial: 'tickets/event', locals: {event: event}
      end

      it 'renders the Event Purchase partial' do
        expect(view).to have_rendered(partial: 'event_purchases/_event_purchase', locals: {event_purchase: event_purchase})
      end

      it 'renders a link to modify the Ticket' do
        expect(rendered).to have_link 'Modify', edit_event_purchase_path(event_purchase)
      end

      it 'renders a link to the Ticket details' do
        expect(rendered).to have_link 'Details', event_purchase_path(event_purchase)
      end
    end

    describe 'when the current User does not have a Ticket for the given Event' do
      before do
        expect(view).to receive(:event_purchase_for_event_for_current_user).and_return(nil)
        render partial: 'tickets/event', locals: {event: event}
      end

      it 'renders a link to buy a Ticket' do
        expect(rendered).to have_link 'Buy Ticket', href: new_event_event_purchase_path(event)
      end
    end
  end
end
