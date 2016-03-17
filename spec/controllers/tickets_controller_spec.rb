describe TicketsController do
  describe 'object seams' do
    describe '.model' do
      it 'returns Event' do
        expect(controller.model).to eq(Ticket)
      end
    end
  end

  describe 'actions' do
    let(:event_model) { double(:Event) }
    let(:model) { double(:Ticket) }
    let(:event) { double(:event) }
    let(:tickets) { double(:tickets) }

    describe '.index' do
      it 'provides all the Tickets for the Event to the view' do
        expect(controller).to receive(:event_model).and_return(event_model)
        expect(controller).to receive(:model).and_return(model)
        expect(event_model).to receive(:find).with('1').and_return(event)
        expect(model).to receive(:find_by).with(event_id: '1').and_return(tickets)

        get :index, event_id: 1

        expect(assigns(:event)).to be(event)
        expect(assigns(:tickets)).to be(tickets)
        expect(response).to render_template('tickets/index')
      end
    end
  end
end
