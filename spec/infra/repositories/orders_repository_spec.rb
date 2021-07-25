require './infra/repositories/orders_repository.rb'
require 'securerandom'

RSpec.describe OrdersRepository do
  after(:each) do
    OrdersRepository.destroy_all
  end

  context 'when asking to create a new Order' do
    it 'persists the new Order properly' do
      merchant = double(id: SecureRandom.uuid)
      shopper = double(id: SecureRandom.uuid)
      attributes = {
        merchant_id: merchant.id,
        shopper_id: shopper.id,
        amount: 15.9
      }

      subject = OrdersRepository.create(attributes)

      expect(subject.values[:id]).to_not be_nil
    end
  end

  context 'when asking for completed orders in the current week' do
    it 'returns a list of them if exists' do
      merchant = double(id: SecureRandom.uuid)
      shopper = double(id: SecureRandom.uuid)
      today = Date.today
      order_of_the_week = OrdersRepository.create(
        {
          merchant_id: merchant.id,
          shopper_id: shopper.id,
          amount: 15.9,
          completed_at: today
        }
      )
      OrdersRepository.create(
        {
          merchant_id: merchant.id,
          shopper_id: shopper.id,
          amount: 15.9,
          completed_at: today - 8
        }
      )
      result = OrdersRepository.find_week_completed_orders

      expect(result.length).to eq(1)
      expect(result.first[:id]).to eq(order_of_the_week.values[:id])
    end
  end
end
