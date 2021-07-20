require 'sequel'

task :migrate do
  Sequel.extension :migration

  database = Sequel.connect(ENV['DATABASE_URL'])
  Sequel::Migrator.run(database, 'db/migrations', :use_transaction => true)
end

task :populate_database do
  require 'json'
  require './infra/repositories/merchants_repository'

  file = File.read('dataset/merchants.json')
  merchants = JSON.parse(file)['RECORDS']

  merchants.each do |merchant_attributes|
    merchant_attributes.delete('id')
    MerchantsRepository.create(merchant_attributes.transform_keys(&:to_sym))
  end
end

task :drop_tables do
  database = Sequel.connect(ENV['DATABASE_URL'])

  database.drop_table?(:schema_info)
  database.drop_table?(:orders)
  database.drop_table?(:merchants)
end
