describe EventsService do
  let(:model) { double(:Event) }
  let(:events) { double(:event) }
  let(:ordered_events) { double(:ordered_events) }

  describe 'object seams' do
    it { expect(subject.model).to eq(Event) }
  end

  describe 'actions' do
    before do
      allow(subject).to receive(:model).and_return(model)
    end

    describe '.upcoming_events' do
      before do
        allow(model).to receive(:where).with('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now).and_return(events)
        allow(events).to receive(:order).with(event_start: :asc).and_return(ordered_events)
      end

      it 'retrieves the purchasable events from the model' do
        expect(subject.upcoming_events).to be(ordered_events)
      end
    end
  end
end
