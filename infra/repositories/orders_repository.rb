require 'json'
require 'date'

class OrdersRepository
  def self.find_week_completed_orders(source = JSON.parse(File.read('./dataset/orders.json')))
    source["RECORDS"].select do |order|
      !order["completed_at"].empty? && DateTime.parse(order["completed_at"]) > (DateTime.now - 7)
    end
  end
end
