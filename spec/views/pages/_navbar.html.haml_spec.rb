describe 'pages/_navbar.html.haml' do
  it 'links to the top' do
    render
    expect(rendered).to have_link 'Collegiate Salsa Open', href: '/'
  end

  it 'links to the Event Information section' do
    render
    expect(rendered).to have_link 'Event Information', href: '/#event-information'
  end

  it 'links to the Tickets page' do
    render
    expect(rendered).to have_link 'Tickets', href: tickets_status_path
  end

  context 'when a User is authenticated' do
    before do
      expect(view).to receive(:logged_in?).and_return(true)
      render
    end

    it 'provides a logout link' do
      expect(rendered).to have_link 'Logout', href: destroy_session_path
      assert_select 'a[href=?][data-method=?]', destroy_session_path, 'delete', 'Logout'
    end
  end

  context 'when there is no User authenticated' do
    before do
      expect(view).to receive(:logged_in?).and_return(false)
      render
    end

    it 'does not provide a logout link' do
      expect(rendered).not_to have_link 'Logout'
    end
  end
end
