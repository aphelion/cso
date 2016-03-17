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

    let(:valid_attributes) { {
        name: 'Full Pass'
    } }

    before do
      allow(controller).to receive(:event_model).and_return(event_model)
      allow(controller).to receive(:model).and_return(model)
      allow(model).to receive(:new).and_return(ticket)
      allow(model).to receive(:find).with('2').and_return(ticket)
      allow(event_model).to receive(:find).with('1').and_return(event)
    end

    describe '.index' do
      it 'provides all the Tickets for the Event to the view' do
        expect(event).to receive(:tickets).and_return(tickets)

        get :index, event_id: 1

        expect(assigns(:event)).to be(event)
        expect(assigns(:tickets)).to be(tickets)
        expect(response).to render_template('tickets/index')
      end
    end

    describe '.new' do
      it 'renders its template' do
        get :new, event_id: 1

        expect(response).to render_template('tickets/new')
      end

      it 'provides a new Ticket to the view' do
        get :new, event_id: 1

        expect(assigns(:ticket)).to be(ticket)
      end

      it 'provides the Event to the view' do
        get :new, event_id: 1

        expect(assigns(:event)).to be(event)
      end
    end

    describe '.edit' do
      it 'renders its template' do
        get :edit, event_id: 1, id: 2

        expect(response).to render_template('tickets/edit')
      end

      it 'provides the Ticket to the view' do
        get :edit, event_id: 1, id: 2

        expect(assigns(:ticket)).to be(ticket)
      end
    end

    describe '.create' do
      context 'with valid attributes' do
        it 'creates a Ticket, saves the Ticket, and redirects to the Tickets page' do
          expect(model).to receive(:new).with(valid_attributes).and_return(ticket)
          expect(ticket).to receive(:event_id=).with('1')
          expect(ticket).to receive(:save).and_return(true)

          post :create, event_id: '1', ticket: valid_attributes

          expect(response).to redirect_to(event_tickets_path(1))
        end
      end

      context 'with invalid attributes' do
        it 'creates a Ticket, tries to save the Ticket, and redirects the Ticket to the new Ticket page' do
          expect(model).to receive(:new).with(valid_attributes).and_return(ticket)
          expect(ticket).to receive(:event_id=).with('1')
          expect(ticket).to receive(:save).and_return(false)

          post :create, event_id: '1', ticket: valid_attributes

          expect(response).to render_template('tickets/new')
          expect(assigns(:ticket)).to eq(ticket)
        end
      end
    end

    describe '.update' do
      context 'with valid attributes' do
        it 'updates the Ticket, and redirects to the Tickets page' do
          expect(model).to receive(:find).with('1').and_return(ticket)
          expect(ticket).to receive(:update).with(valid_attributes).and_return(true)

          put :update, {event_id: '1', id: '1', ticket: valid_attributes}

          expect(response).to redirect_to(event_tickets_path('1'))
        end
      end

      context 'with invalid attributes' do
        it 'tried to update the Ticket, and redirects to the edit Ticket page' do
          expect(model).to receive(:find).with('1').and_return(ticket)
          expect(ticket).to receive(:update).with(valid_attributes).and_return(false)

          put :update, {event_id: '1', id: '1', ticket: valid_attributes}

          expect(response).to render_template('tickets/edit')
          expect(assigns(:ticket)).to eq(ticket)
        end
      end
    end
  end
end
