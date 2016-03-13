describe Identity do
  describe 'custom class methods' do
    describe '.find_with_omniauth' do
      let(:existing_identity_hash) { {uid: 'some-uid', provider: 'facebook'} }

      context 'when the given uid and provider match' do
        it 'returns the identity' do
          Identity.create(existing_identity_hash)
          result = nil
          expect {
            result = Identity.find_or_create_by_omniauth(existing_identity_hash)
          }.to_not change(Identity, :count)

          expect(result).to_not be_nil
          expect(result.uid).to eq('some-uid')
          expect(result.provider).to eq('facebook')
        end
      end

      context 'when only the given uid matches' do
        it 'creates and returns the identity' do
          Identity.create(existing_identity_hash)
          result = nil
          expect {
            result = Identity.find_or_create_by_omniauth({uid: 'some-uid', provider: 'google'})
          }.to change(Identity, :count).by(1)

          expect(result).to_not be_nil
          expect(result.uid).to eq('some-uid')
          expect(result.provider).to eq('google')
        end
      end

      context 'when only the given provider matches' do
        it 'creates and returns the identity' do
          Identity.create(existing_identity_hash)
          result = nil
          expect {
            result = Identity.find_or_create_by_omniauth({uid: 'some-other-uid', provider: 'facebook'})
          }.to change(Identity, :count).by(1)

          expect(result).to_not be_nil
          expect(result.uid).to eq('some-other-uid')
          expect(result.provider).to eq('facebook')
        end
      end

      context 'when neither the given uid or provider match' do
        it 'creates and returns the identity' do
          Identity.create(existing_identity_hash)
          result = nil
          expect {
            result = Identity.find_or_create_by_omniauth({uid: 'some-other-uid', provider: 'google'})
          }.to change(Identity, :count).by(1)

          expect(result).to_not be_nil
          expect(result.uid).to eq('some-other-uid')
          expect(result.provider).to eq('google')
        end
      end

      context 'when the auth object has string keys' do
        context 'when the given uid and provider match' do
          let(:existing_identity_string_key_hash) {
            auth = Hash.new
            auth['uid'] = 'some-uid'
            auth['provider'] = 'facebook'
            auth
          }

          it 'returns the identity' do
            Identity.create(existing_identity_string_key_hash)
            result = nil
            expect {
            result = Identity.find_or_create_by_omniauth(existing_identity_string_key_hash)
            }.to_not change(Identity, :count)

            expect(result).to_not be_nil
            expect(result.uid).to eq('some-uid')
            expect(result.provider).to eq('facebook')
          end
        end
      end
    end
  end
end
