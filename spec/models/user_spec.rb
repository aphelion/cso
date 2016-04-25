describe User do

  let(:user) { User.new }

  describe '.full_name' do

    before do
      user.first_name = 'Sexy'
      user.last_name = 'Salsera'
    end

    it 'combines first and last name' do

      expect(user.full_name).to eq('Sexy Salsera')
    end

    context 'when only first name is set' do
      it 'does not add trailing whitespace' do
        user.last_name = nil
        expect(user.full_name).to eq('Sexy')
      end
    end

    context 'when only last name is set' do
      it 'does not add leading whitespace' do
        user.first_name = nil
        expect(user.full_name).to eq('Salsera')
      end
    end
  end
end
