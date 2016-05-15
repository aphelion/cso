describe 'tickets/my.html.haml' do
  fixtures(:events)
  fixtures(:event_purchases)
  let(:upcoming_events) { [events(:bachata_party), events(:salsa_party)] }
  let(:past_event_event_purchases) { [event_purchases(:crystals_winter_zouk_purchase), event_purchases(:crystals_bachata_party_purchase)] }

  it 'renders a title' do
    assign(:upcoming_events, upcoming_events)
    assign(:past_event_event_purchases, [])
    render
    expect(rendered).to have_text('Tickets')
  end

  describe 'when there are upcoming Events' do
    before do
      assign(:upcoming_events, upcoming_events)
      assign(:past_event_event_purchases, [])
      render
    end

    it 'renders the upcoming Events' do
      upcoming_events.each do |event|
        expect(view).to have_rendered(partial: 'tickets/_event', locals: {event: event})
      end
    end

    it 'does not inform the user there are no upcoming Events' do
      expect(rendered).to_not have_text('There are no upcoming events.')
    end
  end

  describe 'when there are no upcoming Events' do
    before do
      assign(:upcoming_events, [])
      assign(:past_event_event_purchases, [])
      render
    end

    it 'informs the user there are no upcoming Events' do
      expect(rendered).to have_text('There are no upcoming events.')
    end
  end

  describe 'when the user has past Event Purchases' do
    before do
      assign(:upcoming_events, upcoming_events)
      assign(:past_event_event_purchases, past_event_event_purchases)
      render
    end

    it "shows a title for the user's past Event Purchases" do
      expect(rendered).to have_text('Your Past Events')
    end

    it "renders the user's past Event Purchases in a table" do
      expect(view).to have_rendered(partial: 'event_purchases/_event_purchase_table', locals: {event_purchases: past_event_event_purchases})
    end
  end

  describe 'when the user does not have any past Event Purchases' do
    before do
      assign(:upcoming_events, upcoming_events)
      assign(:past_event_event_purchases, [])
      render
    end

    it "does not show a title for the user's past Event Purchases" do
      expect(rendered).to_not have_text('Your Past Events')
    end

    it "does not render the user's past Event Purchases in a table" do
      expect(view).to_not have_rendered(partial: 'event_purchases/_event_purchase_table')
    end
  end
end
