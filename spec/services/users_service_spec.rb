describe UsersService do
  let(:user_model) { double(:User) }
  let(:user) { double(:user) }
  let(:identity) { double(:identity) }
  let(:auth_hash) { double(:auth_hash) }
  let(:info_hash) {
    {'email' => 'user@cso.dance', 'first_name' => 'Johnny', 'last_name' => 'Bachata'}
  }

  describe 'object seams' do
    describe '.user_model' do
      it 'returns User' do
        expect(subject.user_model).to be(User)
      end
    end
  end

  describe 'methods' do
    before do
      allow(subject).to receive(:user_model).and_return(user_model)
    end

    describe '.find_or_create_by_identity' do
      context 'when called with a valid Identity' do
        context 'when the Identity has a User' do
          it "returns the Identity's User" do
            allow(identity).to receive(:user).and_return(user)

            returned_user = subject.find_or_create_by_identity_and_auth_hash(identity, auth_hash)

            expect(returned_user).to be(user)
          end
        end

        context 'when the Identity does not have a User' do
          before do
            allow(auth_hash).to receive(:[]).with('info').and_return(info_hash)
          end

          context 'when no user with the same email address exists' do
            it 'creates returns a new User and updates the Identity to reference it' do
              allow(identity).to receive(:user).and_return(nil)
              expect(user_model).to receive(:find_by).with(email: 'user@cso.dance').and_return(nil)
              expect(user_model).to receive(:create).with(email: 'user@cso.dance',
                                                          first_name: 'Johnny',
                                                          last_name: 'Bachata')
                                        .and_return(user)
              expect(identity).to receive(:user=).with(user)
              expect(identity).to receive(:save)

              returned_user = subject.find_or_create_by_identity_and_auth_hash(identity, auth_hash)

              expect(returned_user).to be(user)
            end
          end

          context 'when a user with the same email address exists' do
            it 'associates the Identity with the User and returns the User' do
              allow(identity).to receive(:user).and_return(nil)
              expect(user_model).to receive(:find_by).with(email: 'user@cso.dance').and_return(user)
              expect(identity).to receive(:user=).with(user)
              expect(identity).to receive(:save)

              returned_user = subject.find_or_create_by_identity_and_auth_hash(identity, auth_hash)

              expect(returned_user).to be(user)
            end
          end
        end
      end
    end
  end
end
