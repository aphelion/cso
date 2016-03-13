describe SessionsController do
  describe '.create' do
    context 'when there is no authenticated User' do
      context 'when a new Identity authenticates' do
        let(:auth_hash) { {uid: 'new-identity-uid', provider: 'facebook'} }

        before do
          @request.env['omniauth.auth'] = auth_hash
        end

        it 'saves a new user with the identity' do
          expect {
            get :create, {provider: 'facebook'}
          }.to change(User, :count).by(1)

          expect(User.last.identities.count).to eq(1)
          expect(User.last.identities.first.uid).to eq(auth_hash[:uid])
        end

        it 'sets the new User id in the session' do
          get :create, {provider: 'facebook'}

          expect(session[:user_id]).to eq(User.last.id)
        end
      end

      context 'when an existing Identity authenticates' do
        let(:auth_hash) { {uid: 'existing-identity-uid', provider: 'facebook'} }
        let!(:existing_identity) { Identity.create(auth_hash) }

        before do
          @request.env['omniauth.auth'] = auth_hash
        end

        context 'when that Identity is associated with a User' do
          let!(:existing_user) do
            user = User.create
            existing_identity.update_attribute(:user, user)
            user
          end

          it 'does not create a new Identity' do
            expect {
              get :create, {provider: 'facebook'}
            }.to_not change(Identity, :count)
          end

          it 'does not create a new User' do
            expect {
              get :create, {provider: 'facebook'}
            }.to_not change(User, :count)
          end

          it 'does not re-save the Identity' do
            expect {
              get :create, {provider: 'facebook'}
            }.to_not change(existing_identity, :updated_at)
          end

          it 'sets the new User id in the session' do
            get :create, {provider: 'facebook'}

            expect(session[:user_id]).to eq(existing_user.id)
          end
        end

        context 'when that Identity is not associated with a User' do
          it 'does not create a new Identity' do
            expect {
              get :create, {provider: 'facebook'}
            }.to_not change(Identity, :count)
          end

          it 'creates a new User with the Identity' do
            expect {
              get :create, {provider: 'facebook'}
            }.to change(User, :count).by(1)

            expect(User.last.identities.count).to eq(1)
            expect(User.last.identities.first.uid).to eq(auth_hash[:uid])
          end

          it 'sets the new User id in the session' do
            get :create, {provider: 'facebook'}

            expect(session[:user_id]).to eq(User.last.id)
          end
        end
      end
    end

    context 'when there is an authenticated User' do
      let!(:user) { User.create }
      before do
        session[:user_id] = user.id
      end

      context 'when a new Identity authenticates' do
        let(:auth_hash) { {uid: 'new-identity-uid', provider: 'facebook'} }

        before do
          @request.env['omniauth.auth'] = auth_hash
        end

        it 'saves the Identity with the User' do
          get :create, {provider: 'facebook'}

          expect(Identity.last.user.id).to eq(user.id)
        end
      end

      context 'when an existing Identity authenticates' do
        let(:auth_hash) { {uid: 'existing-identity-uid', provider: 'facebook'} }
        let!(:existing_identity) { Identity.create(auth_hash) }

        before do
          @request.env['omniauth.auth'] = auth_hash
        end

        context 'when that Identity is associated with the User' do
          before do
            existing_identity.user = user
            existing_identity.save
          end

          it 'does not create a new User' do
            expect {
              get :create, {provider: 'facebook'}
            }.to_not change(User, :count)
          end
        end

        context 'when that Identity is not associated with the User' do
          let!(:other_user) { User.create }

          before do
            existing_identity.user = other_user
            existing_identity.save
          end

          it 'does not create a new User' do
            expect {
              get :create, {provider: 'facebook'}
            }.to_not change(User, :count)
          end

          it 'does not change the User of the Identity' do
            get :create, {provider: 'facebook'}

            expect(existing_identity.user.id).to eq(other_user.id)
          end

          it 'sets the other User id in the session' do
            get :create, {provider: 'facebook'}

            expect(session[:user_id]).to eq(other_user.id)
          end
        end
      end
    end
  end
end
