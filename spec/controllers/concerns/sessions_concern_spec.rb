describe SessionsConcern, type: :controller do
  let(:user_model) { double(:user_model) }
  let(:user) { double(:user) }

  describe 'object seams' do
    controller(ApplicationController) do
      include SessionsConcern
    end

    it { expect(controller.user_model).to be(User) }
  end

  describe 'OTHER THINGS' do
    describe '.logged_in_user' do

      controller(ApplicationController) do
        include SessionsConcern
        before_action :must_be_authenticated

        def action
          head :ok
        end
      end

      before { routes.draw { get 'action' => 'anonymous#action' } }

      context 'when no User is logged in' do
        before do
          expect(controller).to receive(:authenticated?).and_return(false)
        end

        it 'redirects the user to start a session' do
          get :action
          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'when a User is logged in' do
        before do
          expect(controller).to receive(:authenticated?).and_return(true)
        end

        it 'does not redirect the user to start a session' do
          get :action
          expect(response).to_not redirect_to(new_session_path)
        end
      end
    end

    describe '.must_be_admin' do

      controller(ApplicationController) do
        include SessionsConcern
        before_action :must_be_admin

        def action
          head :ok
        end
      end

      before { routes.draw { get 'action' => 'anonymous#action' } }

      context 'when User is an admin' do
        before do
          expect(controller).to receive(:admin?).and_return(true)
        end

        it 'does not block the user from entry' do
          get :action
          expect(response).to_not have_http_status(:forbidden)
        end
      end

      context 'when User is not an admin' do
        before do
          expect(controller).to receive(:admin?).and_return(false)
        end

        it 'blocks the user from entry' do
          get :action
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'concern methods' do
    controller(ApplicationController) do
      include SessionsConcern
    end

    describe '#authenticated?' do
      context 'when a User is logged in' do
        before do
          expect(controller).to receive(:current_user).and_return(user)
        end

        it 'returns true' do
          expect(controller.authenticated?).to eq(true)
        end
      end

      context 'when no User is logged in' do
        before do
          expect(controller).to receive(:current_user).and_return(nil)
        end

        it 'returns true' do
          expect(controller.authenticated?).to eq(false)
        end
      end
    end

    describe '#current_user' do
      before do
        allow(controller).to receive(:user_model).and_return(user_model)
      end

      context 'when uninitialized' do
        context 'when no User is authenticated' do
          it 'returns nil' do
            expect(controller.current_user).to be_nil
          end
        end

        context 'when a User is authenticated' do
          context 'when their User exists' do
            before do
              session[:user_id] = 1
              expect(user_model).to receive(:find_by).with(id: 1).and_return(user)
            end

            it 'returns the user' do
              expect(controller.current_user).to be(user)
            end
          end

          context 'when their User does not exist' do
            before do
              session[:user_id] = 1
              expect(user_model).to receive(:find_by).with(id: 1).and_return(nil)
            end

            it 'returns nil' do
              expect(controller.current_user).to be_nil
            end

            it 'clears session[:user_id]' do
              controller.current_user
              expect(session[:user_id]).to eq(nil)
            end
          end
        end
      end

      context 'when initialized' do
        before do
          session[:user_id] = 1
          expect(user_model).to receive(:find_by).with(id: 1).once.and_return(user)
          controller.current_user
        end

        it 'returns the cached current_user' do
          expect(controller.current_user).to be(user)
        end
      end
    end

    describe '#admin?' do
      context 'when a User is logged in' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        context 'when the User is an admin' do
          before do
            expect(user).to receive(:admin).and_return(true)
          end

          it 'returns true' do
            expect(controller.admin?).to eq(true)
          end
        end

        context 'when the User is not an admin' do
          before do
            expect(user).to receive(:admin).and_return(false)
          end

          it 'returns false' do
            expect(controller.admin?).to eq(false)
          end
        end
      end

      context 'when no User is logged in' do
        before do
          expect(controller).to receive(:current_user).and_return(nil)
        end

        it 'returns false' do
          expect(controller.admin?).to eq(false)
        end
      end
    end

    describe '#authenticate' do
      before do
        session[:user_id] = 99
      end

      context 'when user is valid' do
        it 'updates session[:user_id]' do
          allow(user).to receive(:id).and_return(1)

          controller.authenticate(user)

          expect(session[:user_id]).to eq(1)
        end
      end


      context 'when user is nil' do
        let(:user) { nil }

        it 'does not update session[:user_id]' do

          controller.authenticate(user)

          expect(session[:user_id]).to eq(99)
        end
      end

      context 'when user.id is nil' do
        it 'does not update session[:user_id]' do
          allow(user).to receive(:id).and_return(nil)

          controller.authenticate(user)

          expect(session[:user_id]).to eq(99)
        end
      end
    end
  end
end
