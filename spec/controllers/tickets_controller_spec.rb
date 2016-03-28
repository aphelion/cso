describe TicketsController do
  describe 'object seams' do
    it { expect(controller.model).to eq(Ticket) }
    it { expect(controller.event_model).to eq(Event) }
    it { expect(controller.charge_model).to eq(Charge) }
    it { expect(controller.ticket_option_model).to eq(TicketOption) }
    it { expect(controller.tickets_service).to eq(TicketsService) }
    it { expect(controller.ticket_price_service).to eq(TicketPriceService) }
    it { expect(controller.refund_service).to eq(Stripe::Refund) }
    it { expect(controller.users_service).to eq(UsersService) }
    it { expect(controller.charges_service).to eq(ChargesService) }
  end

  describe 'actions' do
    let(:refund_service) { double(:RefundService) }
    let(:event_model) { double(:Event) }
    let(:charge_model) { double(:Charge) }
    let(:charges_service) { double(:ChargesService) }
    let(:users_service) { double(:UsersService) }
    let(:ticket_option_model) { double(:TicketOption) }
    let(:tickets_service) { double(:TicketsService) }
    let(:ticket_price_service) { double(:TicketPriceService) }
    let(:model) { double(:Ticket) }
    let(:event) { double(:event) }
    let(:ticket_option) { double(:ticket_option) }
    let(:ticket) { double(:ticket) }
    let(:user) { double(:user) }
    let(:errors) { double(:errors) }

    let(:valid_attributes) { {
        ticket_option_id: '2'
    } }

    before do
      allow(controller).to receive(:model).and_return(model)
      allow(controller).to receive(:refund_service).and_return(refund_service)
      allow(controller).to receive(:event_model).and_return(event_model)
      allow(controller).to receive(:charge_model).and_return(charge_model)
      allow(controller).to receive(:charges_service).and_return(charges_service)
      allow(controller).to receive(:users_service).and_return(users_service)
      allow(controller).to receive(:ticket_option_model).and_return(ticket_option_model)
      allow(controller).to receive(:tickets_service).and_return(tickets_service)
      allow(controller).to receive(:ticket_price_service).and_return(ticket_price_service)
      allow(controller).to receive(:current_user).and_return(user)
      allow(model).to receive(:new).and_return(ticket)
      allow(event_model).to receive(:find).with('1').and_return(event)
      allow(ticket_option_model).to receive(:find).with('2').and_return(ticket_option)
    end

    describe 'GET .new' do
      it 'renders its template' do
        get :new, event_id: 1

        expect(response).to render_template('tickets/new')
      end

      it 'provides a new Event to the view' do
        get :new, event_id: 1

        expect(assigns(:event)).to be(event)
      end

      it 'provides a new Ticket to the view' do
        get :new, event_id: 1

        expect(assigns(:ticket)).to be(ticket)
      end

      it 'provides a the current User to the view' do
        get :new, event_id: 1

        expect(assigns(:user)).to be(user)
      end
    end

    describe 'POST .calculate' do
      it 'renders its template' do
        post :calculate, event_id: '1', ticket: valid_attributes

        expect(response).to render_template('tickets/calculate')
      end
    end

    describe 'POST .create' do
      let(:customer) { double(:customer) }
      let(:charge) { double(:charge) }

      before do
        allow(user).to receive(:first_name).and_return('Youngshik')
        allow(user).to receive(:last_name).and_return('Hwang')
        allow(event).to receive(:name).and_return('EVENT')
        allow(ticket_option).to receive(:name).and_return('TICKET_OPTION')
        allow(ticket_option).to receive(:event).and_return(event)

        allow(ticket_price_service).to receive(:ticket_total_price).with(ticket).and_return(Money.new(500))
        allow(users_service).to receive(:find_or_create_customer).with(user, 'STRIPE_TOKEN').and_return(customer)
        allow(charges_service).to receive(:charge_customer).with(customer, 500, 'EVENT TICKET_OPTION for Youngshik Hwang').and_return(charge)

        expect(ticket).to receive(:user=).with(user)
        expect(ticket).to receive(:ticket_option=).with(ticket_option)
        expect(ticket).to receive(:charge=).with(charge)
      end

      context 'when the Charge succeeds' do
        before do
          expect(ticket).to receive(:save).and_return(true)
        end

        it 'creates a Ticket, saves it' do
          post :create, event_id: '1', ticket: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'redirects to the Tickets page' do
          post :create, event_id: '1', ticket: valid_attributes, stripeToken: 'STRIPE_TOKEN'

          expect(response).to redirect_to(user_tickets_path)
        end

        it 'flashes a success message' do
          post :create, event_id: '1', ticket: valid_attributes, stripeToken: 'STRIPE_TOKEN'

          expect(flash[:success]).to_not be_nil
          expect(flash[:success]).to include(event.name)
        end
      end

      context 'when the Ticket.save does not succeed' do
        it 'creates a Ticket, tries to save it, flashes the errors, and redirects to the Event confirmation page' do
          @request.env['HTTP_REFERER'] = root_url
          expect(ticket).to receive(:save).and_return(false)
          expect(ticket).to receive(:errors).and_return(errors)
          expect(errors).to receive(:full_messages).and_return(['some error'])

          post :create, event_id: '1', ticket: valid_attributes, stripeToken: 'STRIPE_TOKEN'

          expect(flash[:error]).to eq('some error')
          expect(response).to redirect_to :back
        end
      end
    end

    describe 'GET .show' do
      let(:hacker) { double(:user) }

      before do
        allow(model).to receive(:find).with('1').and_return(ticket)
        allow(ticket).to receive(:user).and_return(user)
      end

      context 'when the current User is the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        it 'renders its template' do
          get :show, id: '1'

          expect(response).to render_template('tickets/show')
        end

        it 'provides the Ticket to the view' do
          get :show, id: '1'

          expect(assigns(:ticket)).to eq(ticket)
        end
      end

      context 'when the current User is not the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(hacker)
        end

        it 'throws the request in their FACE' do
          get :show, id: '1'

          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    describe 'DELETE .destroy' do
      let(:hacker) { double(:user) }
      let(:charge) { double(:charge) }

      before do
        allow(ticket).to receive(:user).and_return(user)
        allow(model).to receive(:find).with('1').and_return(ticket)
      end

      context 'when the current User is the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
          expect(ticket).to receive(:charge).and_return(charge)
          expect(charge).to receive(:charge_id).and_return('CHARGE_ID')
          expect(refund_service).to receive(:create).with(charge: 'CHARGE_ID', reason: 'requested_by_customer')
          expect(ticket).to receive(:destroy)
        end

        it 'deletes the ticket' do
          delete :destroy, id: '1'
        end

        it 'redirects to the User Tickets page' do
          delete :destroy, id: '1'

          expect(response).to redirect_to(user_tickets_path)
        end

        it 'flashes a confirmation message' do
          delete :destroy, id: '1'

          expect(flash[:success]).to eq("Your ticket was refunded. Sorry you can't make it! You will see this refund reflected on your card in 5-10 business days.")
        end
      end

      context 'when the current User is not the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(hacker)
        end

        it 'throws the request in their FACE' do
          delete :destroy, id: '1'

          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
