describe 'layouts/navbar/_admin.html.haml' do
  context 'when a User is an Admin' do
    before do
      expect(view).to receive(:current_user_admin?).and_return(true)
      render
    end

    it 'provides an Events link' do
      expect(rendered).to have_link 'Events', href: events_path
    end
  end

  context 'when a User is not an Admin' do
    before do
      expect(view).to receive(:current_user_admin?).and_return(false)
      render
    end

    it 'does not provide an Events link' do
      expect(rendered).not_to have_link 'Events', href: events_path
    end
  end
end
