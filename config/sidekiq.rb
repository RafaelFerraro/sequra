require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Dir["#{__dir__}/../infra/workers/**/*.rb"].each { |file| require file }
