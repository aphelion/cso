describe EventPurchasesController do
  let(:event_model) { double(:Event) }
  let(:event_purchase_model) { double(:EventPurchase) }
  let(:charges_service) { double(:ChargesService) }
  let(:event_purchase_price_service) { double(:EventPurchasePriceService) }
  let(:users_service) { double(:UsersService) }
  let(:charges_service) { double(:ChargesService) }
  let(:user) { double(:user) }
  let(:event) { double(:event) }
  let(:ticket_purchase) { double(:ticket_purchase) }
  let(:ticket_product) { double(:ticket_product) }
  let(:addon_purchase_1) { double(:addon_purchase) }
  let(:addon_purchase_2) { double(:addon_purchase) }

  describe 'object seams' do
    it { expect(controller.event_model).to be(Event) }
    it { expect(controller.event_purchase_model).to be(EventPurchase) }
    it { expect(controller.charges_service).to be(ChargesService) }
    it { expect(controller.event_purchase_price_service).to be(EventPurchasePriceService) }
    it { expect(controller.users_service).to be(UsersService) }
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
      allow(controller).to receive(:charges_service).and_return(charges_service)
      allow(controller).to receive(:event_purchase_price_service).and_return(event_purchase_price_service)
      allow(controller).to receive(:users_service).and_return(users_service)
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

    describe 'GET .show' do
      let(:event_purchase) { double(:event_purchase) }
      let(:hacker) { double(:user) }

      before do
        allow(event_purchase_model).to receive(:find).with('1').and_return(event_purchase)
        allow(event_purchase).to receive(:user).and_return(user)
      end

      context 'when the current User is the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        it 'renders its template' do
          get :show, id: '1'

          expect(response).to render_template('event_purchases/show')
        end

        it 'provides the Event Purchase to the view' do
          get :show, id: '1'

          expect(assigns(:event_purchase)).to eq(event_purchase)
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

    describe 'GET .edit' do
      let(:event_purchase) { double(:event_purchase) }
      let(:hacker) { double(:user) }

      before do
        allow(event_purchase_model).to receive(:find).with('1').and_return(event_purchase)
        allow(event_purchase).to receive(:user).and_return(user)
      end

      context 'when the current User is the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        it 'renders its template' do
          get :edit, id: '1'

          expect(response).to render_template('event_purchases/edit')
        end

        it 'provides the Event Purchase to the view' do
          get :edit, id: '1'

          expect(assigns(:event_purchase)).to eq(event_purchase)
        end
      end

      context 'when the current User is not the User of the Ticket' do
        before do
          allow(controller).to receive(:current_user).and_return(hacker)
        end

        it 'throws the request in their FACE' do
          get :edit, id: '1'

          expect(response).to have_http_status(:forbidden)
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

        it 'uses the new_addon params to append a new addon' do
          post :calculate, event_id: '1', event_purchase: valid_attributes, new_addon: {quantity: '2', product_id: '4'}

          appended_addon = assigns(:event_purchase).addon_purchases.last

          expect(appended_addon.quantity).to be(2)
          expect(appended_addon.product_id).to be(4)
        end
      end
    end

    describe 'POST .create' do
      context 'when there is not an authenticated User' do
        it 'redirects to the login page' do
          get :new, event_id: '1'

          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'when there is an authenticated User' do
        let(:customer) { double(:customer) }
        let(:charge) { double(:charge) }
        let(:event_purchase) { double(:event_purchase) }
        let(:price) { double(:price) }

        before do
          allow(controller).to receive(:current_user).and_return(user)
          allow(event_purchase_model).to receive(:new).with(valid_attributes).and_return(event_purchase)
          allow(users_service).to receive(:find_or_create_customer).with(user, 'STRIPE_TOKEN').and_return(customer)
          allow(event_purchase).to receive(:event).and_return(event)
          allow(event_purchase).to receive(:ticket_purchase).and_return(ticket_purchase)
          allow(event).to receive(:name).and_return('EVENT')
          allow(ticket_purchase).to receive(:product).and_return(ticket_product)
          allow(ticket_product).to receive(:name).and_return('TICKET_OPTION')
          allow(user).to receive(:full_name).and_return('Youngshik Hwang')
          allow(event_purchase_price_service).to receive(:event_purchase_total_price).with(event_purchase).and_return(Money.new(500))
          allow(charges_service).to receive(:charge_customer).with(customer, 500, 'EVENT TICKET_OPTION for Youngshik Hwang').and_return(charge)
          allow(ticket_purchase).to receive(:charge=).with(charge)
          allow(event_model).to receive(:find).with('1').and_return(event)
          allow(event_purchase).to receive(:event=)
          allow(event_purchase).to receive(:user=)

          allow(event_purchase).to receive(:addon_purchases).and_return([addon_purchase_1, addon_purchase_2])
          allow(addon_purchase_1).to receive(:charge=).with(charge)
          allow(addon_purchase_2).to receive(:charge=).with(charge)

          allow(event_purchase).to receive(:save)
        end

        it 'gets the total price for the Event Purchase' do
          expect(event_purchase_price_service).to receive(:event_purchase_total_price).with(event_purchase).and_return(Money.new(500))
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'gets a Customer for the User' do
          expect(users_service).to receive(:find_or_create_customer).with(user, 'STRIPE_TOKEN').and_return(customer)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'creates a Charge for the Customer' do
          expect(charges_service).to receive(:charge_customer).with(customer, 500, 'EVENT TICKET_OPTION for Youngshik Hwang').and_return(charge)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'adds the Charge to Ticket Purchase' do
          expect(ticket_purchase).to receive(:charge=).with(charge)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'adds the Charge to all Addon Purchases' do
          expect(addon_purchase_1).to receive(:charge=).with(charge)
          expect(addon_purchase_2).to receive(:charge=).with(charge)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'sets the Event of the Event Purchase' do
          expect(event_purchase).to receive(:event=).with(event)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'sets the Event of the Event Purchase' do
          expect(event_purchase).to receive(:user=).with(user)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'saves the Event Purchase' do
          expect(event_purchase).to receive(:save)
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'
        end

        it 'redirects to the Tickets page' do
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'

          expect(response).to redirect_to(my_tickets_path)
        end

        it 'flashes a success message' do
          post :create, event_id: '1', event_purchase: valid_attributes, stripeToken: 'STRIPE_TOKEN'

          expect(flash[:success]).to_not be_nil
          expect(flash[:success]).to include(event.name)
        end
      end
    end
  end
end
