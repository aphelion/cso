describe 'tickets/_table.html.haml' do
  fixtures(:tickets)
  let(:bachata_party_tickets) { [tickets(:bachata_party_full_pass), tickets(:bachata_party_night_pass)] }

  before do
    render partial: 'tickets/table', locals: {tickets: bachata_party_tickets}
  end

  describe 'structure' do
    it 'renders the header in a table' do
      # expect(rendered).to have_selector('table thead')
      expect(rendered).to have_rendered(partial: 'tickets/table/_header')
    end

    it 'renders the rows in a body in a table' do
      # expect(rendered).to have_selector('table tbody tr')
      expect(rendered).to have_rendered(partial: 'tickets/table/_row', count: bachata_party_tickets.count)
    end
  end
end
