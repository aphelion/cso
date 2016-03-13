describe 'pages/_navbar.html.haml' do
  before do
    render
  end

  describe 'navigation' do
    it 'links to the top' do
      expect(rendered).to have_link 'Collegiate Salsa Open', href: '/'
    end

    it 'links to the Event Information section' do
      expect(rendered).to have_link 'Event Information', href: '/#event-information'
    end

    it 'links to the Registration page' do
      expect(rendered).to have_link 'Registration'
    end
  end
end
