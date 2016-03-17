describe 'events/edit.html.haml' do
  fixtures(:events)
  let(:event) { events(:bachata_party) }

  before do
    assign(:event, event)
    render
  end

  it 'renders a form for the Event' do
    expect(view).to have_rendered(partial: 'form', locals: {event: event, cancel_path: events_path})
  end
end
