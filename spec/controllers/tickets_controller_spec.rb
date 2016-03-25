describe TicketsController do
  describe 'object seams' do
    it { expect(controller.model).to eq(Ticket) }
    it { expect(controller.event_model).to eq(Event) }
    it { expect(controller.ticket_option_model).to eq(TicketOption) }
  end

  describe 'actions' do
    let(:event_model) { double(:Event) }
    let(:ticket_option_model) { double(:TicketOption) }
    let(:model) { double(:Ticket) }
    let(:event) { double(:event) }
    let(:ticket_option) { double(:ticket_option) }
    let(:ticket) { double(:ticket) }
    let(:user) { double(:user) }
    let(:errors) { double(:errors) }

    before do
      allow(controller).to receive(:model).and_return(model)
      allow(controller).to receive(:event_model).and_return(event_model)
      allow(controller).to receive(:ticket_option_model).and_return(ticket_option_model)
      allow(controller).to receive(:current_user).and_return(user)
      allow(model).to receive(:new).and_return(ticket)
      allow(event_model).to receive(:find).with('1').and_return(event)
      allow(ticket_option_model).to receive(:find).with('2').and_return(ticket_option)
    end

    describe '.new' do
      it 'renders its template' do
        get :new, event_id: 1, ticket_option_id: 2

        expect(response).to render_template('tickets/new')
      end

      it 'provides a new Event to the view' do
        get :new, event_id: 1, ticket_option_id: 2

        expect(assigns(:event)).to be(event)
      end

      it 'provides a new Ticket Option to the view' do
        get :new, event_id: 1, ticket_option_id: 2

        expect(assigns(:ticket_option)).to be(ticket_option)
      end

      it 'provides a new Ticket to the view' do
        get :new, event_id: 1, ticket_option_id: 2

        expect(assigns(:ticket)).to be(ticket)
      end
    end

    describe '.create' do
      before do
        expect(model).to receive(:new).and_return(ticket)
        expect(ticket).to receive(:ticket_option_id=).with('2')
        expect(ticket).to receive(:user=).with(user)
      end

      context 'when the Ticket is valid' do
        it 'creates a Ticket, saves it, and redirects to the Event confirmation page' do
          expect(ticket).to receive(:save).and_return(true)
          expect(ticket).to receive(:id).and_return(1)

          post :create, event_id: '1', ticket_option_id: '2'

          expect(response).to redirect_to(ticket_path(1))
        end
      end

      context 'when the Ticket is not valid' do
        it 'creates a Ticket, tries to save it, flashes the errors, and redirects to the Event confirmation page' do
          @request.env['HTTP_REFERER'] = root_url
          expect(ticket).to receive(:save).and_return(false)
          expect(ticket).to receive(:errors).and_return(errors)
          expect(errors).to receive(:full_messages).and_return(['some error'])

          post :create, event_id: '1', ticket_option_id: '2'

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

      before do
        allow(ticket).to receive(:user).and_return(user)
        allow(model).to receive(:find).with('1').and_return(ticket)
      end

      context 'when the current User is the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        it 'deletes the ticket' do
          expect(ticket).to receive(:destroy)

          delete :destroy, id: '1'
        end

        it 'redirects to the User Tickets page' do
          allow(ticket).to receive(:destroy)

          delete :destroy, id: '1'

          expect(response).to redirect_to(user_tickets_path)
        end

        it 'flashes a confirmation message' do
          allow(ticket).to receive(:destroy)

          delete :destroy, id: '1'

          expect(flash[:success]).to eq('Your ticket has been refunded.')
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
