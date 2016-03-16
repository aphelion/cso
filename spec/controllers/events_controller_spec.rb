describe EventsController do
  describe 'authorization' do
    context 'when User is not an admin' do
      before do
        expect(controller).to receive(:current_user_admin?).and_return(false)
      end

      it 'blocks the user from entry' do
        get :index

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when User is an admin' do
      before do
        expect(controller).to receive(:current_user_admin?).and_return(true)
      end

      it 'does not block the user from entry' do
        get :index

        expect(response).to_not have_http_status(:forbidden)
      end
    end
  end

  describe 'GET .index' do
    before do
      expect(controller).to receive(:current_user_admin?).and_return(true)
    end

    it 'renders its template' do
      get :index

      expect(response).to render_template('events/index')
    end
  end
end
