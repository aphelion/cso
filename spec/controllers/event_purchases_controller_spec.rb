describe EventPurchasesController do
  let(:event_model) { double(:Event) }
  let(:event_purchase_model) { double(:EventPurchase) }
  let(:user) { double(:user) }

  describe 'object seams' do
    it { expect(controller.event_model).to be(Event) }
    it { expect(controller.event_purchase_model).to be(EventPurchase) }
  end

  describe 'actions' do

    let(:valid_attributes) { {
        ticket_purchase_attributes: {
            product_id: '1'
        }
    } }

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
          allow(controller).to receive(:current_user).and_return(user)
          allow(event_purchase_model).to receive(:new).and_return(event_purchase)
          allow(event_model).to receive(:find).with('1').and_return(event)
        end

        it 'renders its template' do
          get :new, event_id: '1'

          expect(response).to render_template('event_purchases/new')
        end

        it 'assigns a new Event Purchase as @event_purchase' do
          get :new, event_id: '1'

          expect(assigns(:event_purchase)).to be(event_purchase)
        end

        it 'assigns the current user as @user' do
          get :new, event_id: '1'

          expect(assigns(:user)).to be(user)
        end

        it "sets the new Event Purchase's Event as to the Event for the given id" do
          get :new, event_id: '1'

          expect(assigns(:event_purchase).event).to be(event)
        end

        it "sets the new Event Purchase's Ticket Purchase as a new Product Purchase" do
          get :new, event_id: '1'

          expect(assigns(:event_purchase).ticket_purchase).to be_a_new(ProductPurchase)
        end
      end
    end

    describe 'POST .calculate' do
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
          allow(controller).to receive(:current_user).and_return(user)
          allow(event_purchase_model).to receive(:new).and_return(event_purchase)
          allow(event_model).to receive(:find).with('1').and_return(event)
        end

        it 'renders its template' do
          post :calculate, event_id: '1', event_purchase: valid_attributes

          expect(response).to render_template('event_purchases/calculate')
        end

        it 'assigns the current user as @user' do
          post :calculate, event_id: '1', event_purchase: valid_attributes

          expect(assigns(:user)).to be(user)
        end

        it 'assigns a new Event Purchase with the posted attributes' do
          post :calculate, event_id: '1', event_purchase: valid_attributes

          expect(assigns(:event_purchase)).to be(event_purchase)
        end
      end
    end
  end
end
