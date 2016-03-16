describe 'layouts/application.html.haml' do
  before do
    render
  end

  it 'renders a navigation bar' do
    expect(view).to have_rendered(partial: 'layouts/_navbar')
  end
end
