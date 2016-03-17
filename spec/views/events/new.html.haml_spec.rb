describe 'events/new.html.haml' do
  let(:event) { Event.new }

  before do
    assign(:event, event)
    render
  end

  it 'renders a form for the new Event' do
    expect(view).to have_rendered(partial: 'form', locals: {event: event, cancel_path: events_path})
  end
end
