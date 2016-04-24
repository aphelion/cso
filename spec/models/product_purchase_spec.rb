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
end
