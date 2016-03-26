describe 'pages/home.html.haml' do
  before do
    render
  end

  it 'renders the landing section' do
    expect(view).to have_rendered(partial: 'pages/_landing')
  end

  it 'renders the Event Information section' do
    expect(view).to have_rendered(partial: 'pages/_event_information')
  end

  it 'renders the CSO 2015 section' do
    expect(view).to have_rendered(partial: 'pages/_cso_2015')
  end

  it 'renders the About section' do
    expect(view).to have_rendered(partial: 'pages/_about')
  end
end
