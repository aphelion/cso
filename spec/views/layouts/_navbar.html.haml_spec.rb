describe 'layouts/_navbar.html.haml' do
  before do
    render
  end

  it 'links to the top' do
    expect(rendered).to have_link 'Collegiate Salsa Open', href: '/'
  end

  it 'links to the Event Information section' do
    expect(rendered).to have_link 'Event Information', href: '/#event-information'
  end

  it 'links to the Tickets page' do
    expect(rendered).to have_link 'Tickets', href: user_tickets_path
  end

  it 'renders the Session links' do
    expect(view).to have_rendered(partial: 'layouts/navbar/_session')
  end

  it 'renders the Admin links' do
    expect(view).to have_rendered(partial: 'layouts/navbar/_admin')
  end
end
