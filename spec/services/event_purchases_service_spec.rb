describe EventPurchasesService do

  describe 'object seams' do
    it { expect(subject.model).to eq(EventPurchase) }
  end

  describe 'actions' do
    let(:model) { double(:EventPurchase) }
    let(:event) { double(:event) }
    let(:user) { double(:user) }
    let(:event_purchase) { double(:event_purchase) }
    let(:past_event_event_purchases) { double(:past_event_event_purchases) }

    before do
      allow(subject).to receive(:model).and_return(model)
    end

    describe '.find_by_event_and_user' do
      before do
        allow(model).to receive(:find_by).with(event: event, user: user).and_return(event_purchase)
      end

      it 'retrieves the purchasable events from the model' do
        returned_event_purchase = subject.find_by_event_and_user(event, user)

        expect(returned_event_purchase).to be(event_purchase)
      end
    end

    describe '.past_event_event_purchases' do
      before do
        allow(model).to receive(:where).with(user: user,)
        allow(model).to receive_message_chain(:where, :joins, :where, :order).and_return(past_event_event_purchases)
      end

      it "retrieves the given User's Event Purchases for past Events" do
        returned_tickets = subject.past_event_event_purchases(user)

        expect(returned_tickets).to be(past_event_event_purchases)
      end
    end
  end
end
