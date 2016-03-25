describe UsersController do
  let(:events_service) { double(:EventsService) }
  let(:upcoming_events) { double(:upcoming_events) }

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
        allow(events_service).to receive(:upcoming_events).and_return(upcoming_events)
      end

      it 'renders its template' do
        get :tickets

        expect(response).to render_template('users/tickets')
      end

      it 'provides a list of upcoming Events to the view' do
        get :tickets

        expect(assigns(:upcoming_events)).to be(upcoming_events)
      end
    end
  end
end
