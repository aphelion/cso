describe TicketsController do
  describe 'object seams' do
    it { expect(controller.model).to eq(Ticket) }
    it { expect(controller.event_model).to eq(Event) }
  end

  describe 'actions' do
    let(:event_model) { double(:Event) }
    let(:model) { double(:Ticket) }
    let(:event) { double(:event) }
    let(:tickets) { double(:tickets) }
    let(:ticket) { double(:ticket) }

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

    describe '.new' do
      before do
        allow(controller).to receive(:model).and_return(model)
        allow(model).to receive(:new).and_return(ticket)
      end

      it 'renders its template' do
        get :new, event_id: 1

        expect(response).to render_template('tickets/new')
      end

      it 'provides a new Ticket to the view' do
        get :new, event_id: 1

        expect(assigns(:ticket)).to be(ticket)
      end
    end
  end
end
