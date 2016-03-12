describe PagesController do
  describe 'GET .index' do
    it 'renders its template' do
      get :index

      expect(response).to render_template('pages/index')
    end
  end
end
