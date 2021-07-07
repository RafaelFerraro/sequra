require './domain/disbursement'

RSpec.describe Disbursement do
  it 'creates a new disbursement from an order' do
    calculate_fee = double(:calculate_fee)
    order = { "merchant_id" => "123", "amount" => 50.0 }
    allow(calculate_fee).to receive(:calculate_for_amount).with(50.0).and_return(0.5)

    subject = described_class.create_from_order(order, calculate_fee)

    expect(subject.merchant_id).to eq("123")
    expect(subject.amount).to eq(0.5)
    expect(subject.id).to_not be_nil
    expect(subject.disbursed_at).to_not be_nil
  end
end
