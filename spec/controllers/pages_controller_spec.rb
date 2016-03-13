describe PagesController do
  describe 'GET .home' do
    it 'renders its template' do
      get :home

      expect(response).to render_template('pages/home')
    end
  end
end
