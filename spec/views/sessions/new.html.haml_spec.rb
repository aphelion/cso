describe 'sessions/new.html.haml' do
  before do
    render
  end

  it 'links to Facebook authentication' do
    expect(rendered).to have_link 'Facebook', '/sessions/facebook'
  end

  it 'links to Google authentication' do
    expect(rendered).to have_link 'Google', '/sessions/google'
  end
end
