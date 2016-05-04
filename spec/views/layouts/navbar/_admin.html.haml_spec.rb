describe 'layouts/navbar/_admin.html.haml' do
  context 'when a User is an Admin' do
    before do
      expect(view).to receive(:admin?).and_return(true)
      render
    end

    it 'provides an Events link' do
      expect(rendered).to have_link 'Admin', href: admin_home_path
    end
  end

  context 'when a User is not an Admin' do
    before do
      expect(view).to receive(:admin?).and_return(false)
      render
    end

    it 'does not provide an Events link' do
      expect(rendered).not_to have_link 'Events', href: admin_home_path
    end
  end
end
