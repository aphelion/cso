describe TicketOptionsController do
  describe 'object seams' do
    it { expect(controller.model).to eq(TicketOption) }
    it { expect(controller.event_model).to eq(Event) }
  end

  describe 'actions' do
    let(:event_model) { double(:Event) }
    let(:model) { double(:TicketOption) }
    let(:event) { double(:event) }
    let(:ticket_options) { double(:ticket_options) }
    let(:ticket_option) { double(:ticket_option) }

    let(:valid_attributes) { {
        name: 'Full Pass'
    } }

    before do
      allow(controller).to receive(:event_model).and_return(event_model)
      allow(controller).to receive(:model).and_return(model)
      allow(model).to receive(:new).and_return(ticket_option)
      allow(model).to receive(:find).with('2').and_return(ticket_option)
      allow(event_model).to receive(:find).with('1').and_return(event)
    end

    describe '.index' do
      it 'provides all the Tickets for the Event to the view' do
        expect(event).to receive(:ticket_options).and_return(ticket_options)

        get :index, event_id: 1

        expect(assigns(:event)).to be(event)
        expect(assigns(:ticket_options)).to be(ticket_options)
        expect(response).to render_template('ticket_options/index')
      end
    end

    describe '.new' do
      it 'renders its template' do
        get :new, event_id: 1

        expect(response).to render_template('ticket_options/new')
      end

      it 'provides a new Ticket Option to the view' do
        get :new, event_id: 1

        expect(assigns(:ticket_option)).to be(ticket_option)
      end

      it 'provides the Event to the view' do
        get :new, event_id: 1

        expect(assigns(:event)).to be(event)
      end
    end

    describe '.edit' do
      it 'renders its template' do
        get :edit, event_id: 1, id: 2

        expect(response).to render_template('ticket_options/edit')
      end

      it 'provides the Ticket Option to the view' do
        get :edit, event_id: 1, id: 2

        expect(assigns(:ticket_option)).to be(ticket_option)
      end
    end

    describe '.create' do
      context 'with valid attributes' do
        it 'creates a Ticket Option, saves the Ticket Option, and redirects to the Ticket Options page' do
          expect(model).to receive(:new).with(valid_attributes).and_return(ticket_option)
          expect(ticket_option).to receive(:event_id=).with('1')
          expect(ticket_option).to receive(:save).and_return(true)

          post :create, event_id: '1', ticket_option: valid_attributes

          expect(response).to redirect_to(event_ticket_options_path(1))
        end
      end

      context 'with invalid attributes' do
        it 'creates a Ticket Option, tries to save the Ticket Option, and redirects the Ticket Option to the new Ticket Option page' do
          expect(model).to receive(:new).with(valid_attributes).and_return(ticket_option)
          expect(ticket_option).to receive(:event_id=).with('1')
          expect(ticket_option).to receive(:save).and_return(false)

          post :create, event_id: '1', ticket_option: valid_attributes

          expect(response).to render_template('ticket_options/new')
          expect(assigns(:ticket_option)).to eq(ticket_option)
        end
      end
    end

    describe '.update' do
      context 'with valid attributes' do
        it 'updates the Ticket Option, and redirects to the Ticket Options page' do
          expect(model).to receive(:find).with('1').and_return(ticket_option)
          expect(ticket_option).to receive(:update).with(valid_attributes).and_return(true)

          put :update, {event_id: '1', id: '1', ticket_option: valid_attributes}

          expect(response).to redirect_to(event_ticket_options_path('1'))
        end
      end

      context 'with invalid attributes' do
        it 'tried to update the Ticket Option, and redirects to the edit Ticket Option page' do
          expect(model).to receive(:find).with('1').and_return(ticket_option)
          expect(ticket_option).to receive(:update).with(valid_attributes).and_return(false)

          put :update, {event_id: '1', id: '1', ticket_option: valid_attributes}

          expect(response).to render_template('ticket_options/edit')
          expect(assigns(:ticket_option)).to eq(ticket_option)
        end
      end
    end
  end
end
