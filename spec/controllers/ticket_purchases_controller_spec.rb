describe TicketPurchasesController do
  describe 'object seams' do
    it { expect(controller.model).to eq(TicketPurchase) }
    it { expect(controller.event_model).to eq(Event) }
    it { expect(controller.ticket_model).to eq(Ticket) }
  end

  describe 'actions' do
    let(:event_model) { double(:Event) }
    let(:ticket_model) { double(:Ticket) }
    let(:model) { double(:TicketPurchase) }
    let(:event) { double(:event) }
    let(:ticket) { double(:ticket) }
    let(:ticket_purchase) { double(:ticket_purchase) }
    let(:user) { double(:user) }

    before do
      allow(controller).to receive(:model).and_return(model)
      allow(controller).to receive(:event_model).and_return(event_model)
      allow(controller).to receive(:ticket_model).and_return(ticket_model)
      allow(controller).to receive(:current_user).and_return(user)
      allow(model).to receive(:new).and_return(ticket_purchase)
      allow(event_model).to receive(:find).with('1').and_return(event)
      allow(ticket_model).to receive(:find).with('2').and_return(ticket)
    end

    describe '.new' do
      it 'renders its template' do
        get :new, event_id: 1, ticket_id: 2

        expect(response).to render_template('ticket_purchases/new')
      end

      it 'provides a new Event to the view' do
        get :new, event_id: 1, ticket_id: 2

        expect(assigns(:event)).to be(event)
      end

      it 'provides a new Ticket to the view' do
        get :new, event_id: 1, ticket_id: 2

        expect(assigns(:ticket)).to be(ticket)
      end

      it 'provides a new Ticket Purchase to the view' do
        get :new, event_id: 1, ticket_id: 2

        expect(assigns(:ticket_purchase)).to be(ticket_purchase)
      end
    end

    describe '.create' do
      it 'creates a Ticket Purchase, saves it, and redirects to the Event confirmation page' do
        expect(model).to receive(:new).and_return(ticket_purchase)
        expect(ticket_purchase).to receive(:event_id=).with('1')
        expect(ticket_purchase).to receive(:ticket_id=).with('2')
        expect(ticket_purchase).to receive(:user=).with(user)
        expect(ticket_purchase).to receive(:save).and_return(true)

        post :create, event_id: '1', ticket_id: '2'

        expect(response).to redirect_to(confirmation_event_path(1))
      end
    end

    describe 'GET .show' do
      let(:hacker) { double(:user) }

      before do
        allow(model).to receive(:find).with('1').and_return(ticket_purchase)
        allow(ticket_purchase).to receive(:user).and_return(user)
        allow(ticket_purchase).to receive(:event).and_return(event)
      end

      context 'when the current User is the User of the Ticket Purchase' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        it 'renders its template' do
          get :show, id: '1'

          expect(response).to render_template('ticket_purchases/show')
        end

        it 'provides the Event to the view' do
          get :show, id: '1'

          expect(assigns(:event)).to eq(event)
        end

        it 'provides the User to the view' do
          get :show, id: '1'

          expect(assigns(:user)).to eq(user)
        end
      end

      context 'when the current User is not the User of the Ticket Purchase' do
        before do
          allow(controller).to receive(:current_user).and_return(hacker)
        end

        it 'does not show the user a confirmation screen' do
          get :show, id: '1'

          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
