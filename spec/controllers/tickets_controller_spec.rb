describe TicketsController do
  describe 'object seams' do
    it { expect(controller.model).to eq(Ticket) }
    it { expect(controller.event_model).to eq(Event) }
  end

  describe 'actions' do
    let(:event_model) { double(:Event) }
    let(:event) { double(:event) }
    let(:tickets) { double(:tickets) }

    describe '.index' do
      it 'provides all the Tickets for the Event to the view' do
        expect(controller).to receive(:event_model).and_return(event_model)
        expect(event_model).to receive(:find).with('1').and_return(event)
        expect(event).to receive(:tickets).and_return(tickets)

        get :index, event_id: 1

        expect(assigns(:event)).to be(event)
        expect(assigns(:tickets)).to be(tickets)
        expect(response).to render_template('tickets/index')
      end
    end
  end
end
