describe TicketsController do
  let(:events_service) { double(:EventsService) }
  let(:event_purchases_service) { double(:EventPurchasesService) }
  let(:upcoming_events) { double(:upcoming_events) }
  let(:past_event_event_purchases) { double(:past_event_event_purchases) }
  let(:event) { double(:event) }
  let(:user) { double(:user) }

  describe 'object seams' do
    it { expect(controller.events_service).to be(EventsService) }
    it { expect(controller.event_purchases_service).to be(EventPurchasesService) }
  end

  describe 'actions' do
    before do
      allow(controller).to receive(:events_service).and_return(events_service)
      allow(controller).to receive(:event_purchases_service).and_return(event_purchases_service)
    end

    describe '.my' do
      context 'when there is not an authenticated User' do
        it 'redirects to the login page' do
          get :my

          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'when there is an authenticated User' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
          allow(events_service).to receive(:upcoming_events).and_return(upcoming_events)
          allow(event_purchases_service).to receive(:past_event_event_purchases).with(user).and_return(past_event_event_purchases)
        end

        it 'renders its template' do
          get :my

          expect(response).to render_template('tickets/my')
        end

        it 'provides a list of upcoming Events to the view' do
          get :my

          expect(assigns(:upcoming_events)).to be(upcoming_events)
        end

        it "provides a list of the User's past_event_event_purchases to the view" do
          get :my

          expect(assigns(:past_event_event_purchases)).to be(past_event_event_purchases)
        end
      end
    end
  end
end
