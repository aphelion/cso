describe 'pages/home.html.haml' do
  before do
    render
  end

  it 'renders the landing section' do
    expect(view).to have_rendered(partial: 'pages/_landing')
  end

  it 'renders the Past Events section' do
    expect(view).to have_rendered(partial: 'pages/_cso_archive')
  end

  it 'renders the About section' do
    expect(view).to have_rendered(partial: 'pages/_about')
  end
end
