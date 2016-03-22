describe EventsService do
  let(:model) { double(:Event) }
  let(:events) { [double(:event), double(:event)] }

  describe 'object seams' do
    it { expect(subject.model).to eq(Event) }
  end

  describe 'actions' do
    before do
      allow(subject).to receive(:model).and_return(model)
    end

    describe '.purchasable_events' do
      before do
        allow(model).to receive(:where).with('sale_start < ? AND sale_end > ?', DateTime.now, DateTime.now).and_return(events)
      end

      it 'retrieves the purchasable events from the model' do
        expect(subject.purchasable_events).to be(events)
      end
    end
  end
end
