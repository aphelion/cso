include MoneyRails::ActionViewExtension

describe 'event_purchases/_addon_selection.html.haml' do
  fixtures(:events)
  fixtures(:products)
  fixtures(:product_options)
  let(:event) { events(:bachata_party) }
  let(:event_purchase) { EventPurchase.new }

  before do
    event_purchase.event = event
  end

  context 'when a user already has an Addon' do
    let(:addon) { event.addons.first }

    before do
      event_purchase.addon_purchases << ProductPurchase.new(product: addon)
      render partial: 'event_purchases/addon_selection', locals: {event_purchase: event_purchase}
    end

    it 'does not render the button to add that Addon' do
      expect(rendered).to_not have_button addon.name
    end
  end

  context 'when a user lands on the Event Purchase form' do
    before do
      render partial: 'event_purchases/addon_selection', locals: {event_purchase: event_purchase}
    end

    it 'renders a button for each Addon' do
      event.addons.each do |addon|
        assert_select 'button', "Add #{addon.name}"
        expect(rendered).to have_text(addon.name)
      end
    end

    it 'renders the description for each Addon' do
      event.addons.each do |addon|
        expect(rendered).to have_text(addon.description)
      end
    end

    it 'renders the description for each Addon' do
      event.addons.each do |addon|
        expect(rendered).to have_text(humanized_money_with_symbol addon.price)
      end
    end

    describe 'the Addon modal' do
      it 'renders a quantity dropdown menu' do
        event.addons.each do |addon|
          expect(rendered).to have_selector("#addon-modal-#{addon.id} [name='addon_#{addon.id}[quantity]']")
        end
      end

      it 'renders product options dropdown menus' do
        event.addons.each do |addon|
          addon.options.each do |option|
            expect(rendered).to have_selector("#addon-modal-#{addon.id} [name='addon_#{addon.id}[#{option.name}]']")
          end
        end
      end
    end
  end
end
