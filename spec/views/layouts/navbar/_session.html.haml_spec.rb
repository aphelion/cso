describe 'layouts/navbar/_session.html.haml' do
  context 'when a User is authenticated' do
    before do
      expect(view).to receive(:authenticated?).and_return(true)
      render
    end

    it 'provides a logout link' do
      expect(rendered).to have_link 'Logout', href: destroy_session_path
      assert_select 'a[href=?][data-method=?]', destroy_session_path, 'delete', 'Logout'
    end
  end

  context 'when there is no User authenticated' do
    before do
      expect(view).to receive(:authenticated?).and_return(false)
      render
    end

    it 'does not provide a logout link' do
      expect(rendered).not_to have_link 'Logout'
    end
  end
end
