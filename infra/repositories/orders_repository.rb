require 'json'

class OrdersRepository
  def initialize(source = nil)
    @source = source || JSON.parse(File.read('./dataset/orders.json'))
  end

  def find_completed_orders
    @source["RECORDS"].select { |order| !order["completed_at"].nil? }
  end
end
