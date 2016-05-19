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

    describe 'GET #home' do
      it_behaves_like 'an admin endpoint'
      let(:user) { double(:user) }

      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:admin).and_return(true)
        allow(events_service).to receive(:upcoming_events).and_return(upcoming_events)
      end

      def do_request
        get :home
      end

      it 'renders its template' do
        do_request

        expect(response).to render_template('admin/home')
      end

      it 'provides a list of upcoming Events to the view' do
        do_request

        expect(assigns(:upcoming_events)).to be(upcoming_events)
      end
    end
  end
end
