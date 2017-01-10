describe 'pages/_event_information.html.haml' do
  before do
    render
  end

  describe 'navigation' do
    it 'has an anchor tag' do
      expect(rendered).to have_css('#event-information')
    end

    it 'links to the Tickets page' do
      expect(rendered).to have_link 'Tickets', my_tickets_path
    end

    it 'links to the CSO 2015 section' do
      expect(rendered).to have_link 'Past Events', href: '/#cso-archive'
    end

    it 'links to the About section' do
      expect(rendered).to have_link 'About', href: '/#about'
    end
  end
end
