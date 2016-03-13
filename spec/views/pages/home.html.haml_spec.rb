describe 'pages/home.html.haml' do
  before do
    render
  end

  it 'renders a navigation bar' do
    expect(view).to have_rendered(partial: 'pages/_navbar')
  end

  it 'renders the landing section' do
    expect(view).to have_rendered(partial: 'pages/_landing')
  end

  it 'renders the Event Information section' do
    expect(view).to have_rendered(partial: 'pages/_event_information')
  end
end
