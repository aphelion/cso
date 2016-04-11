describe EventPurchaseHelper do

  describe 'object seams' do
    it { expect(helper.service).to eq(EventPurchasesService) }
  end

  describe 'actions' do
    let(:service) { double(:EventPurchasesService) }
    let(:user) { double(:user) }
    let(:event) { double(:event) }
    let(:event_purchase) { double(:event_purchase) }

    before do
      allow(helper).to receive(:service).and_return(service)
      allow(helper).to receive(:current_user).and_return(user)
    end

    describe '.event_purchase_for_event_for_current_user' do
      before do
        allow(service).to receive(:find_by_event_and_user).with(event, user).and_return(event_purchase)
      end

      it 'use the passed Event and the current User to find an Event Purchase' do
        expect(helper.event_purchase_for_event_for_current_user(event)).to be(event_purchase)
      end
    end
  end
end
