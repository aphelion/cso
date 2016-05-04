describe AdminController do
  let(:events_service) { double(:EventsService) }
  let(:upcoming_events) { double(:upcoming_events) }

  describe 'object seams' do
    it { expect(controller.events_service).to be(EventsService) }
  end

  describe 'actions' do
    before do
      allow(controller).to receive(:events_service).and_return(events_service)
    end

    describe 'GET .home' do
      context 'when the user is an admin' do
        before do
          allow(controller).to receive(:must_be_admin)
          allow(events_service).to receive(:upcoming_events).and_return(upcoming_events)
        end

        it 'renders its template' do
          get :home

          expect(response).to render_template('admin/home')
        end

        it 'provides a list of upcoming Events to the view' do
          get :home

          expect(assigns(:upcoming_events)).to be(upcoming_events)
        end
      end

      context 'when the user is an admin' do
        it 'returns forbidden' do
          get :home

          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
