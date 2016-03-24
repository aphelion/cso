describe SessionsController do
  describe 'object seams' do
    it { expect(subject.identities_service).to be(IdentitiesService) }
    it { expect(subject.users_service).to be(UsersService) }
  end

  describe 'methods' do
    let(:identities_service) { double(:IdentitiesService) }
    let(:users_service) { double(:UsersService) }
    let(:auth_hash) { {uid: 'some-uid', provider: 'facebook'} }
    let(:identity) { double(:identity) }
    let(:user) { double(:user) }

    before do
      allow(controller).to receive(:identities_service).and_return(identities_service)
      allow(controller).to receive(:users_service).and_return(users_service)
    end

    describe '.callback' do
      before do
        @request.env['omniauth.auth'] = auth_hash
      end

      it 'logs the user in' do
        expect(identities_service).to receive(:find_or_create_by_auth_hash).with(auth_hash).and_return(identity)
        expect(users_service).to receive(:find_or_create_by_identity_and_auth_hash).with(identity, auth_hash).and_return(user)
        expect(controller).to receive(:log_in).with(user)

        get :callback, auth_hash

        expect(response).to redirect_to(user_tickets_path)
      end
    end

    describe '.new' do
      it 'renders its template' do
        get :new

        expect(response).to render_template('sessions/new')
      end
    end

    describe '.destroy' do
      before do
        session[:user_id] = 123
      end

      it 'removes user_id from the session' do
        delete :destroy

        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the homepage' do
        delete :destroy

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
