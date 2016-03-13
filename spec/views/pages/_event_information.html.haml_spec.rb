describe 'pages/_event_information.html.haml' do
  before do
    render
  end

  describe 'navigation' do
    it 'has an anchor tag' do
      expect(rendered).to have_css('#event-information')
    end
  end
end
