describe UsersController do
  let(:events_service) { double(:EventsService) }
  let(:purchasable_events) { double(:purchasable_events) }
  let(:upcoming_purchased_tickets) { double(:upcoming_purchased_tickets) }

  describe 'object seams' do
    it { expect(controller.events_service).to be(EventsService) }
  end

  describe '.status' do
    context 'when there is not an authenticated User' do
      it 'redirects to the login page' do
        get :tickets

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when there is an authenticated User' do
      before do
        expect(controller).to receive(:must_be_authenticated)
        allow(controller).to receive(:events_service).and_return(events_service)
        allow(events_service).to receive(:purchasable_events).and_return(purchasable_events)
        allow(events_service).to receive(:upcoming_purchased_tickets).and_return(upcoming_purchased_tickets)
      end

      it 'renders its template' do
        get :tickets

        expect(response).to render_template('users/tickets')
      end

      it 'provides a list of purchasable events to the view' do
        get :tickets

        expect(assigns(:purchasable_events)).to be(purchasable_events)
      end

      it 'provides a list of purchasable events to the view' do
        get :tickets

        expect(assigns(:upcoming_purchased_tickets)).to be(upcoming_purchased_tickets)
      end
    end
  end
end
