describe 'ticket_options/_table.html.haml' do
  fixtures(:ticket_options)
  let(:bachata_party_tickets) { [ticket_options(:bachata_party_full_pass), ticket_options(:bachata_party_night_pass)] }

  before do
    render partial: 'ticket_options/table', locals: {ticket_options: bachata_party_tickets}
  end

  describe 'structure' do
    it 'renders the header in a table' do
      # expect(rendered).to have_selector('table thead')
      expect(rendered).to have_rendered(partial: 'ticket_options/table/_header')
    end

    it 'renders the rows in a body in a table' do
      # expect(rendered).to have_selector('table tbody tr')
      expect(rendered).to have_rendered(partial: 'ticket_options/table/_row', count: bachata_party_tickets.count)
    end
  end
end
