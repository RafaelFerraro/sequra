require 'sequel'

task :migrate do
  Sequel.extension :migration

  database = Sequel.connect(ENV['DATABASE_URL'])
  Sequel::Migrator.run(database, 'db/migrations', :use_transaction => true)
end

task :populate_database do
  require 'json'
  require './infra/repositories/merchants_repository'
  require './infra/repositories/shoppers_repository'
  require './infra/repositories/orders_repository'

  merchants_dataset = File.read('dataset/merchants.json')
  merchants = JSON.parse(merchants_dataset)['RECORDS']

  created_merchants = merchants.map do |merchant_attributes|
    merchant_attributes.delete('id')
    MerchantsRepository.create(merchant_attributes.transform_keys(&:to_sym))
  end

  shoppers_dataset = File.read('dataset/shoppers.json')
  shoppers = JSON.parse(shoppers_dataset)['RECORDS']

  created_shoppers = shoppers.map do |shopper_attributes|
    shopper_attributes.delete('id')
    ShoppersRepository.create(shopper_attributes.transform_keys(&:to_sym))
  end

  orders_dataset = File.read('dataset/orders.json')
  orders = JSON.parse(orders_dataset)['RECORDS']

  orders.each do |order_attributes|
    order_attributes.delete('id')
    order_attributes = order_attributes.transform_keys(&:to_sym)
    updated_attributes = order_attributes.merge(
      {
        merchant_id: created_merchants[order_attributes[:merchant_id].to_i - 1][:id],
        shopper_id: created_shoppers[order_attributes[:shopper_id].to_i - 1][:id]
      }
    )

    OrdersRepository.create(updated_attributes)
  end
end

task :drop_tables do
  database = Sequel.connect(ENV['DATABASE_URL'])

  database.drop_table?(:schema_info)
  database.drop_table?(:merchants)
  database.drop_table?(:shoppers)
  database.drop_table?(:orders)
end
