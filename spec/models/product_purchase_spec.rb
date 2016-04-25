describe ProductPurchase do

  let(:product_purchase) { ProductPurchase.new }

  describe '.quantity' do
    it 'is invalid if quantity is less than 1' do
      product_purchase.quantity = 0

      expect(product_purchase).to_not be_valid
    end

    it 'is valid if quantity is greater than 0' do
      product_purchase.quantity = 1

      expect(product_purchase).to be_valid
    end
  end

  describe '.total_price' do
    context 'when there is no Product set' do
      it 'returns 0' do
        expect(product_purchase.total_price).to eq(0)
      end
    end

    context 'when there is a Product set' do
      before do
        product_purchase.product = Product.new(price: 500)
      end

      it 'returns 0 when quantity is 0' do
        product_purchase.quantity = 0

        expect(product_purchase.total_price).to eq(Money.new(0))
      end

      it 'returns the Product price when quantity is 1' do
        product_purchase.quantity = 1

        expect(product_purchase.total_price).to eq(product_purchase.product.price)
      end
    end
  end
end
