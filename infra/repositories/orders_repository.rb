require 'json'
require 'date'

DB ||= Sequel.connect(ENV['DATABASE_URL'])
class Order < Sequel::Model(:orders)
  plugin :uuid, :field => :id
  plugin :timestamps
end

class OrdersRepository
  def self.create(attributes = {})
    Order.create(attributes)
  end

  def self.find_week_completed_orders(source = JSON.parse(File.read('./dataset/orders.json')))
    source["RECORDS"].select do |order|
      !order["completed_at"].empty? && DateTime.parse(order["completed_at"]) > (DateTime.now - 7)
    end
  end
end
