describe 'pages/index.html.haml' do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_text('CSO 2016')
  end
end
