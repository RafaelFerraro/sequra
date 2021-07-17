require 'sequel'

task :migrate do
  Sequel.extension :migration

  database = Sequel.connect(ENV['DATABASE_URL'])
  Sequel::Migrator.run(database, 'db/migrations', :use_transaction => true)
end

task :populate_database do
  require 'json'
  require './domain/merchant'

  file = File.read('dataset/merchants.json')
  merchants = JSON.parse(file)['RECORDS']
  database = Sequel.connect(ENV['DATABASE_URL'])

  merchants.each do |merchant_attributes|
    merchants_table = database[:merchants]
    merchants_table.insert(merchant_attributes.transform_keys(&:to_sym))
  end
end
