DB ||= Sequel.connect(ENV['DATABASE_URL'])
class Shopper < Sequel::Model(:shoppers)
  plugin :uuid, :field => :id
  plugin :timestamps
end

class ShoppersRepository
  def self.create(attributes = {})
    Shopper.create(attributes)
  end
end
