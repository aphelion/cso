describe 'pages/_event_information.html.haml' do
  before do
    render
  end

  describe 'navigation' do
    it 'has an anchor tag' do
      expect(rendered).to have_css('#event-information')
    end

    it 'links to the Tickets page' do
      expect(rendered).to have_link 'Tickets', tickets_status_path
    end
  end
end
