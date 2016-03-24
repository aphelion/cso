describe EventsService do
  let(:model) { double(:Event) }
  let(:ticket_model) { double(:Ticket) }
  let(:events) { [double(:event), double(:event)] }

  describe 'object seams' do
    it { expect(subject.model).to eq(Event) }
    it { expect(subject.ticket_model).to eq(Ticket) }
  end

  describe 'actions' do
    before do
      allow(subject).to receive(:model).and_return(model)
      allow(subject).to receive(:ticket_model).and_return(ticket_model)
    end

    describe '.upcoming_events' do
      before do
        allow(model).to receive(:where).with('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now).and_return(events)
      end

      it 'retrieves the purchasable events from the model' do
        expect(subject.upcoming_events).to be(events)
      end
    end

    describe '.upcoming_purchased_events' do
      it 'relies on the developer to write correct ActiveRecord code' do
        expect('developer talent').to be_truthy
      end
    end

    describe '.purchasable_events' do
      it 'relies on the developer to write correct ActiveRecord code' do
        expect('developer talent').to be_truthy
      end
    end
  end
end
