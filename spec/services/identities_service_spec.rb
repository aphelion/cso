describe IdentitiesService do
  let(:identity_model) { double(:Identity) }
  let(:identity) { double(:identity) }
  let(:auth_hash) { {uid: 'some-uid', provider: 'facebook'} }

  before do
    allow(subject).to receive(:identity_model).and_return(identity_model)
  end

  describe '.find_or_create_by_auth_hash' do
    context 'when called with a valid auth hash' do
      before do
        allow(identity_model).to receive(:find_by).with(uid: 'some-uid', provider: 'facebook').and_return(identity)
      end

      it 'returns the identity' do
        returned_identity = subject.find_or_create_by_auth_hash(auth_hash)

        expect(returned_identity).to be(identity)
      end
    end

    describe 'malformed auth hashes' do
      context 'when uid is not present' do
        let(:auth_hash) { {provider: 'facebook'} }

        it 'returns nil' do
          returned_identity = subject.find_or_create_by_auth_hash(auth_hash)

          expect(returned_identity).to be_nil
        end
      end

      context 'when uid is nil' do
        let(:auth_hash) { {uid: nil, provider: 'facebook'} }

        it 'returns nil' do
          returned_identity = subject.find_or_create_by_auth_hash(auth_hash)

          expect(returned_identity).to be_nil
        end
      end

      context 'when facebook is not present' do
        let(:auth_hash) { {uid: 'some-uid'} }

        it 'returns nil' do
          returned_identity = subject.find_or_create_by_auth_hash(auth_hash)

          expect(returned_identity).to be_nil
        end
      end

      context 'when uid is nil' do
        let(:auth_hash) { {uid: 'some-uid', provider: nil} }

        it 'returns nil' do
          returned_identity = subject.find_or_create_by_auth_hash(auth_hash)

          expect(returned_identity).to be_nil
        end
      end
    end
  end
end
