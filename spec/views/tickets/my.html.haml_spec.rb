describe 'tickets/my.html.haml' do
  fixtures(:events)
  let(:upcoming_events) { [events(:bachata_party), events(:salsa_party)] }

  before do
    assign(:upcoming_events, upcoming_events)
    render
  end

  it 'renders a title' do
    expect(rendered).to have_text('Tickets')
  end

  it 'renders the upcoming Events' do
    upcoming_events.each do |event|
      expect(view).to have_rendered(partial: 'tickets/_event', locals: {event: event})
    end
  end
end
