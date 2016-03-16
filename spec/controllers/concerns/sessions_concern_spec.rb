describe SessionsConcern, type: :controller do

  describe '.logged_in_user' do

    controller(ApplicationController) do
      include SessionsConcern
      before_action :logged_in_user

      def action
        redirect_to root_path
      end
    end

    before { routes.draw { get 'action' => 'anonymous#action' } }

    context 'when no User is logged in' do
      before do
        expect(controller).to receive(:logged_in?).and_return(false)
      end

      it 'redirects the user to start a session' do
        get :action
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when a User is logged in' do
      before do
        expect(controller).to receive(:logged_in?).and_return(true)
      end

      it 'does not redirect the user to start a session' do
        get :action
        expect(response).to_not redirect_to(new_session_path)
      end
    end
  end

  describe '.admin_user' do

    controller(ApplicationController) do
      include SessionsConcern
      before_action :admin_user

      def action
        redirect_to root_path
      end
    end

    before { routes.draw { get 'action' => 'anonymous#action' } }

    context 'when User is an admin' do
      before do
        expect(controller).to receive(:current_user_admin?).and_return(true)
      end

      it 'does not block the user from entry' do
        get :action
        expect(response).to_not have_http_status(:forbidden)
      end
    end

    context 'when User is not an admin' do
      before do
        expect(controller).to receive(:current_user_admin?).and_return(false)
      end

      it 'blocks the user from entry' do
        get :action
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
