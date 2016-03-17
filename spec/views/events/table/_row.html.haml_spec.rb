describe 'events/table/_row.html.haml' do
  fixtures(:events)
  let(:event) { events(:bachata_party) }

  before do
    render partial: 'events/table/row', locals: {event: event}
  end

  it 'shows the Event name' do
    assert_select 'tr td:nth-child(1)', {text: event.name}
  end

  it 'renders a link to the Event edit page' do
    assert_select 'tr td:nth-child(2) a[href=?]', edit_event_path(event), 'Edit'
  end

  it 'renders a link to the Event show page' do
    assert_select 'tr td:nth-child(2) a[href=?]', event_path(event), 'Show'
  end
end
