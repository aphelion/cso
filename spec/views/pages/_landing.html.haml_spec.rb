describe 'pages/_landing.html.haml' do
  before do
    render
  end

  describe 'navigation' do
    it 'links to the Event Information section' do
      expect(rendered).to have_link 'Learn More', href: '/#event-information'
    end
  end
end
