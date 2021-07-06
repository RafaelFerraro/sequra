require './infra/repositories/orders_repository.rb'

RSpec.describe OrdersRepository do
  context 'when asking for completed orders in the week' do
    it 'returns a list of them if exists' do
      json_list = {
        "RECORDS" => [
          {
            "id" => "1",
            "merchant_id" => "10",
            "shopper_id" => "328",
            "amount" => "287.22",
            "created_at" => "01/01/2018 19:57:00",
            "completed_at" => nil
          },
          {
            "id" => "2",
            "merchant_id" => "8",
            "shopper_id" => "327",
            "amount" => "288.71",
            "created_at" => "01/01/2018 20:54:00",
            "completed_at" => (DateTime.now - 2).strftime("%d/%m/%Y %H:%M:%S")
          },
          {
            "id" => "2",
            "merchant_id" => "8",
            "shopper_id" => "327",
            "amount" => "288.71",
            "created_at" => "05/07/2021 20:54:00",
            "completed_at" => (DateTime.now - 8).strftime("%d/%m/%Y %H:%M:%S")
          }
        ]
      }

      result = OrdersRepository.new(json_list).find_week_completed_orders

      expect(result.length).to eq(1)
      expect(result.first["id"]).to eq("2")
    end

    it 'returns an empty list if there is none' do
      json_list = {
        "RECORDS" => [
          {
            "id" => "1",
            "merchant_id" => "10",
            "shopper_id" => "328",
            "amount" => "287.22",
            "created_at" => "01/01/2018 19:57:00",
            "completed_at" => nil
          },
          {
            "id" => "2",
            "merchant_id" => "8",
            "shopper_id" => "327",
            "amount" => "288.71",
            "created_at" => "01/01/2018 20:54:00",
            "completed_at" => nil
          }
        ]
      }

      result = OrdersRepository.new(json_list).find_week_completed_orders

      expect(result.empty?).to eq(true)
    end
  end
end
