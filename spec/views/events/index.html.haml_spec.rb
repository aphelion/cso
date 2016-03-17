describe 'events/index.html.haml' do
  it 'links to the new Event page' do
    render
    assert_select 'a', 'New Event', href: new_event_path
  end
end
