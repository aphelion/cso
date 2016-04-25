describe UsersService do
  let(:user_model) { double(:User) }
  let(:customer_model) { double(:Customer) }
  let(:stripe_customer_service) { double(:'Stripe::Customer') }
  let(:user) { double(:user) }
  let(:customer) { double(:customer) }
  let(:stripe_customer) { double(:stripe_customer) }
  let(:identity) { double(:identity) }
  let(:auth_hash) { double(:auth_hash) }
  let(:info_hash) {
    {'email' => 'user@cso.dance', 'first_name' => 'Johnny', 'last_name' => 'Bachata'}
  }

  describe 'object seams' do
    it { expect(subject.user_model).to be(User) }
    it { expect(subject.customer_model).to be(Customer) }
    it { expect(subject.stripe_customer_service).to be(Stripe::Customer) }
  end

  describe 'methods' do
    before do
      allow(subject).to receive(:user_model).and_return(user_model)
      allow(subject).to receive(:customer_model).and_return(customer_model)
      allow(subject).to receive(:stripe_customer_service).and_return(stripe_customer_service)
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

    describe '.find_or_create_customer' do
      let(:stripe_token) { 'STRIPE_TOKEN' }
      context 'when User has a customer' do
        before do
          allow(user).to receive(:customer).and_return(customer)
        end

        it 'returns the customer' do
          returnedCustomer = subject.find_or_create_customer(user, stripe_token)

          expect(returnedCustomer).to be(customer)
        end
      end

      context 'when User does not have a customer' do
        before do
          allow(user).to receive(:full_name).and_return('FIRST LAST')
          allow(user).to receive(:email).and_return('EMAIL')
          allow(user).to receive(:customer).and_return(nil)
          allow(stripe_customer_service).to receive(:create).with(
              description: 'FIRST LAST',
              email: 'EMAIL',
              source: 'STRIPE_TOKEN'
          ).and_return(stripe_customer)
          allow(stripe_customer).to receive(:id).and_return(1)
          allow(customer_model).to receive(:create).with(user: user, customer_id: 1, processor: 'stripe').and_return(customer)
        end

        it 'creates and returns a new customer' do
          returnedCustomer = subject.find_or_create_customer(user, stripe_token)

          expect(returnedCustomer).to be(customer)
        end
      end
    end
  end
end
