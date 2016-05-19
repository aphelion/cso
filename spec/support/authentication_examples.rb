# caller must define:
# do_request
shared_examples 'an authenticated endpoint' do
  let(:auth_user) { double(:user) }

  def login
    allow(controller).to receive(:current_user).and_return(auth_user)
  end

  def logout
    allow(controller).to receive(:current_user).and_return(nil)
  end

  context 'when logged in' do
    it 'lets me in' do
      login
      do_request
      expect(response).to(be_successful)
    end
  end

  context 'when not logged in' do
    it 'doesnt let me in' do
      logout
      do_request
      expect(response).to_not(be_successful)
    end
  end
end

# caller must define:
# do_request
shared_examples 'an admin endpoint' do
  let(:auth_user) { double(:user) }

  def login
    allow(controller).to receive(:current_user).and_return(auth_user)
    allow(auth_user).to receive(:admin).and_return(true)
  end

  def login_not_admin
    allow(controller).to receive(:current_user).and_return(auth_user)
    allow(auth_user).to receive(:admin).and_return(false)
  end

  def logout
    allow(controller).to receive(:current_user).and_return(nil)
  end

  context 'when logged in' do
    it 'lets me in' do
      login
      do_request
      expect(response).to(be_successful)
    end
  end

  context 'when not admin' do
    it 'doesnt let me in' do
      login_not_admin
      do_request
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when not logged in' do
    it 'doesnt let me in' do
      logout
      do_request
      expect(response).to_not(be_successful)
    end
  end
end
