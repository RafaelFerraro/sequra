require 'json'
require 'date'
require 'rack/test'
require './application/controllers/disbursements_controller'
require './infra/repositories/disbursements_repository'
require './domain/disbursement'

RSpec.describe "DisbursementsController" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  after(:each) do
    File.open(ENV['DISBURSEMENTS_DATASET_SOURCE'], 'w') do |f|
      f.puts JSON.pretty_generate({"RECORDS": []})
    end
  end

  context 'when there is no disbursements created' do
    it 'returns 200 as status code with an empty body' do
      get "/disbursements"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).empty?).to eq(true)
    end
  end

  context 'when there are disbursements created' do
    it 'returns 200 as status code with an empty body' do
      disbursement = Disbursement.new(
        merchant_id: 1,
        disbursed_at: DateTime.now,
        amount: 2.5
      )
      DisbursementsRepository.create(disbursement)

      get "/disbursements"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).length).to eq(1)
    end
  end
end
