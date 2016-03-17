describe EventsController do
  describe 'authorization' do
    context 'when User is not an admin' do
      before do
        expect(controller).to receive(:current_user_admin?).and_return(false)
      end

      it 'blocks the user from entry' do
        get :index

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when User is an admin' do
      before do
        expect(controller).to receive(:current_user_admin?).and_return(true)
      end

      it 'does not block the user from entry' do
        get :index

        expect(response).to_not have_http_status(:forbidden)
      end
    end
  end

  context 'object seams' do
    it 'provides the model via #model' do
      expect(controller.model).to eq(Event)
    end
  end

  context 'actions (as Admin)' do
    let(:model) { double(:Event) }
    let(:event) { double(:event) }
    let(:events) { double(:events) }

    before do
      expect(controller).to receive(:current_user_admin?).and_return(true)
      allow(controller).to receive(:model).and_return(model)
    end

    describe 'GET .index' do
      before do
        expect(model).to receive(:all).and_return(events)
      end

      it 'renders its template' do
        get :index

        expect(response).to render_template('events/index')
      end

      it 'assigns all Events to @events' do
        get :index

        expect(assigns(:events)).to eq(events)
      end
    end

    describe 'GET .new' do
      before do
        allow(model).to receive(:new).and_return(event)
      end

      it 'renders its template' do
        get :new

        expect(response).to render_template('events/new')
      end

      it 'assigns a new event as @event' do
        get :new

        expect(assigns(:event)).to be(event)
      end
    end

    describe 'POST .create' do
      let(:valid_attributes) { {
          name: 'an event',
          event_start: '2016-01-01T00:00',
          event_end: '2016-01-02T00:00',
          sale_start: '2015-12-01T00:00',
          sale_end: '2015-12-31T00:00'
      } }

      context 'with valid attributes' do
        it 'creates a Event, saves the Event, and redirects to the Events page' do
          expect(model).to receive(:new).with(valid_attributes).and_return(event)
          expect(event).to receive(:save).and_return(true)

          post :create, event: valid_attributes

          expect(response).to redirect_to(events_path)
        end
      end

      context 'with invalid attributes' do
        it 'creates a Event, tries to save the Event, and redirects the Event to the new Event page' do
          expect(model).to receive(:new).with(valid_attributes).and_return(event)
          expect(event).to receive(:save).and_return(false)

          post :create, event: valid_attributes

          expect(response).to redirect_to(new_event_path)
          expect(assigns(:event)).to eq(event)
        end
      end
    end
  end
end
