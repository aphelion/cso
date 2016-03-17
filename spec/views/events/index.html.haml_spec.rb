describe 'events/index.html.haml' do
  fixtures(:events)
  let(:all_events) { [events(:bachata_party), events(:salsa_party)] }

  before do
    assign(:events, all_events)
    render
  end

  it 'renders all Events in a table' do
    expect(view).to have_rendered(partial: 'events/_table', locals: {events: all_events})
  end

  it 'links to the new Event page' do
    assert_select 'a', 'New Event', href: new_event_path
  end
end
