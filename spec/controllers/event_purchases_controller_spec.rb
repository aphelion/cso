describe EventPurchasesController do
  let(:event_model) { double(:Event) }
  let(:event_purchase_model) { double(:EventPurchase) }
  let(:event) { double(:event) }

  describe 'object seams' do
    it { expect(controller.event_model).to be(Event) }
    it { expect(controller.event_purchase_model).to be(EventPurchase) }
  end

  describe 'actions' do
    before do
      allow(controller).to receive(:event_model).and_return(event_model)
      allow(controller).to receive(:event_purchase_model).and_return(event_purchase_model)
    end


    describe '.new' do
      context 'when there is not an authenticated User' do
        it 'redirects to the login page' do
          get :new, event_id: '1'

          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'when there is an authenticated User' do
        let(:event) { Event.new }
        let(:event_purchase) { EventPurchase.new }

        before do
          allow(controller).to receive(:must_be_authenticated)
          allow(event_model).to receive(:find).with('1').and_return(event)
          allow(event_purchase_model).to receive(:new).and_return(event_purchase)
        end

        it 'renders its template' do
          get :new, event_id: '1'

          expect(response).to render_template('event_purchases/new')
        end

        it 'assigns a new Event Purchase as @event_purchase' do
          get :new, event_id: '1'

          expect(assigns(:event_purchase)).to be(event_purchase)
        end

        it "sets the new Event Purchase's Event as to the Event for the given id" do
          get :new, event_id: '1'

          expect(assigns(:event_purchase).event).to be(event)
        end
      end
    end
  end
end
