describe ChargesService do
  describe 'object seams' do
    it { expect(subject.charge_model).to be(Charge) }
    it { expect(subject.stripe_charge_service).to be(Stripe::Charge) }
  end

  describe '.charge_customer' do
    let(:charge_model) { double(:charge_model) }
    let(:stripe_charge_service) { double(:stripe_charge_service) }
    let(:customer) { double(:customer) }
    let(:amount) { 500 }
    let(:description) { 'DESCRIPTION' }
    let(:stripe_charge) { double(:stripe_charge) }
    let(:charge) { double(:charge) }

    before do
      allow(subject).to receive(:charge_model).and_return(charge_model)
      allow(subject).to receive(:stripe_charge_service).and_return(stripe_charge_service)
      allow(customer).to receive(:customer_id).and_return(1)
      allow(stripe_charge).to receive(:id).and_return(2)
    end

    it 'charges the customer the amount provided' do
      expect(stripe_charge_service).to receive(:create).with(
          customer: 1,
          amount: amount,
          description: 'DESCRIPTION',
          currency: 'USD'
      ).and_return(stripe_charge)

      expect(charge_model).to receive(:create).with(
          charge_id: 2,
          processor: 'stripe'
      ).and_return(charge)

      returnedCharge = subject.charge_customer(customer, amount, description)

      expect(returnedCharge).to be(charge)
    end
  end
end
