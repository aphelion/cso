describe UsersController do
  describe '.status' do
    context 'when there is not an authenticated User' do
      it 'redirects to the login page' do
        get :tickets

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when there is an authenticated User' do
      before do
        expect(controller).to receive(:logged_in?).and_return(true)
      end

      it 'renders its template' do
        get :tickets

        expect(response).to render_template('users/tickets')
      end
    end
  end
end
