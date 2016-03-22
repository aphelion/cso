describe UsersController do
  let(:events_service) { double(:EventsService) }
  let(:events) { double(:events) }

  describe 'object seams' do
    it { expect(controller.events_service).to be_an_instance_of(EventsService) }
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
        expect(controller).to receive(:logged_in_user)
        allow(controller).to receive(:events_service).and_return(events_service)
        allow(events_service).to receive(:purchasable_events).and_return(events)
      end

      it 'renders its template' do
        get :tickets

        expect(response).to render_template('users/tickets')
      end

      it 'provides a list of purchasable events to the view' do
        get :tickets

        expect(assigns(:purchasable_events)).to be(events)
      end
    end
  end
end
