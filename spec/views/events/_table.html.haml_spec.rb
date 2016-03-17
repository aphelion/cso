describe 'events/_table.html.haml' do
  fixtures(:events)
  let(:all_events) { [events(:bachata_party), events(:salsa_party)] }

  before do
    render partial: 'events/table', locals: {events: all_events}
  end

  describe 'structure' do
    it 'renders the header in a table' do
      expect(rendered).to have_selector('table thead')
      expect(rendered).to have_rendered(partial: 'events/table/_header')
    end

    it 'renders the rows in a body in a table' do
      expect(rendered).to have_selector('table tbody tr')
      expect(rendered).to have_rendered(partial: 'events/table/_row', count: all_events.count)
    end
  end
end
