describe 'layouts/application.html.haml' do
  before do
    render
  end

  it 'renders a navigation bar' do
    expect(view).to have_rendered(partial: 'layouts/_navbar')
  end

  it 'renders flash messages' do
    expect(view).to have_rendered(partial: 'layouts/_flash')
  end
end
