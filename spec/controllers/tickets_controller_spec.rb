describe TicketsController do
  describe '.status' do
    context 'when there is not an authenticated User' do
      it 'redirects to the login page' do
        get :status

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when there is an authenticated User' do
      let!(:user) { User.create }
      before do
        session[:user_id] = user.id
      end

      it 'renders its template' do
        get :status

        expect(response).to render_template('tickets/status')
      end
    end
  end

end
