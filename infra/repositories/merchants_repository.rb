DB = Sequel.connect(ENV['DATABASE_URL'])
class Merchant < Sequel::Model(:merchants)
  plugin :uuid, :field => :id
  plugin :timestamps
end

class MerchantsRepository
  def self.create(attributes = {})
    Merchant.create(attributes)
  end
end