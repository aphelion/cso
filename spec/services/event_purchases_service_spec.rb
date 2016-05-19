describe EventPurchasesService do

  describe 'object seams' do
    it { expect(subject.model).to eq(EventPurchase) }
  end

  describe 'actions' do
    fixtures(:all)

    let(:event) { events(:salsa_party) }
    let(:user)  { users(:crystal) }
    let(:event_purchase) { event_purchases(:crystals_salsa_party_purchase) }
    let(:past_event_event_purchase) { event_purchases(:crystals_bachata_party_purchase) }

    describe '.find_by_event_and_user' do
      it 'retrieves the purchasable events from the model' do
        returned_event_purchase = subject.find_by_event_and_user(event, user)
        expect(returned_event_purchase).to eq(event_purchase)
      end
    end

    describe '.past_event_event_purchases' do
      it "retrieves the given User's Event Purchases for past Events" do
        returned_tickets = subject.past_event_event_purchases(user)

        expect(returned_tickets).to include(past_event_event_purchase)
      end
    end
  end
end
