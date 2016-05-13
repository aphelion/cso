describe 'tickets/my.html.haml' do
  fixtures(:events)
  let(:upcoming_events) { [events(:bachata_party), events(:salsa_party)] }

  it 'renders a title' do
    assign(:upcoming_events, upcoming_events)
    render
    expect(rendered).to have_text('Tickets')
  end

  describe 'when there are upcoming Events' do
    before do
      assign(:upcoming_events, upcoming_events)
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
      render
    end

    it 'informs the user there are no upcoming Events' do
      expect(rendered).to have_text('There are no upcoming events.')
    end
  end
end
