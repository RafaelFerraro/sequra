require 'json'
require 'sinatra'
require './infra/repositories/disbursements_repository'

get '/disbursements' do
  DisbursementsRepository.all.to_json
end
