describe SessionsHelper do
  let(:user_model) { double(:user_model) }
  let(:user) { double(:user) }

  describe '.logged_in?' do
    context 'when .current_user returns a user' do
      before do
        expect(helper).to receive(:current_user).and_return(user)
      end

      it 'returns true' do
        expect(helper.logged_in?).to eq(true)
      end
    end

    context 'when .current_user returns nil' do
      before do
        expect(helper).to receive(:current_user).and_return(nil)
      end

      it 'returns true' do
        expect(helper.logged_in?).to eq(false)
      end
    end
  end

  describe '.current_user' do
    before do
      allow(helper).to receive(:user_model).and_return(user_model)
    end

    context 'when uninitialized' do
      context 'when no User is authenticated' do
        it 'returns nil' do
          expect(current_user).to be_nil
        end
      end

      context 'when a User is authenticated' do
        before do
          session[:user_id] = 1
          expect(user_model).to receive(:find).with(1).and_return(user)
        end

        it 'returns the user' do
          expect(current_user).to be(user)
        end
      end
    end

    context 'when initialized' do
      before do
        session[:user_id] = 1
        expect(user_model).to receive(:find).with(1).once.and_return(user)
        current_user
      end

      it 'returns the cached current_user' do
        expect(current_user).to be(user)
      end
    end
  end

  describe '.log_in' do
    before do
      session[:user_id] = 99
    end

    context 'when user is valid' do
      it 'updates session[:user_id]' do
        allow(user).to receive(:id).and_return(1)

        helper.log_in(user)

        expect(session[:user_id]).to eq(1)
      end
    end


    context 'when user is nil' do
      let(:user) { nil }

      it 'does not update session[:user_id]' do

        helper.log_in(user)

        expect(session[:user_id]).to eq(99)
      end
    end

    context 'when user.id is nil' do
      it 'does not update session[:user_id]' do
        allow(user).to receive(:id).and_return(nil)

        helper.log_in(user)

        expect(session[:user_id]).to eq(99)
      end
    end
  end
end
