require 'json'
require 'date'

class OrdersRepository
  def initialize(source = nil)
    @source = source || JSON.parse(File.read('./dataset/orders.json'))
  end

  def find_week_completed_orders
    @source["RECORDS"].select do |order|
      order["completed_at"] && DateTime.parse(order["completed_at"]) > (DateTime.now - 7)
    end
  end
end
