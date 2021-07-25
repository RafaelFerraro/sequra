require 'json'
require 'date'
require 'sequel'

DB ||= Sequel.connect(ENV['DATABASE_URL'])

class Order < Sequel::Model(:orders)
  plugin :uuid, :field => :id
  plugin :timestamps
end

class OrdersRepository
  def self.all
    Order.all
  end

  def self.create(attributes)
    Order.create(attributes)
  end

  def self.find_week_completed_orders
    Order.where(
      completed_at: (DateTime.now - 7)...(DateTime.now)
    ).all
  end

  def self.destroy_all
    Order.all.each(&:destroy)
  end
end
