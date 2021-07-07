require 'date'
require './domain/disbursement'
require './infra/repositories/disbursements_repository'

RSpec.describe DisbursementsRepository do
  after(:each) do
    File.open(source, 'w') do |f|
      f.puts JSON.pretty_generate({"RECORDS": []})
    end
  end

  context 'when asking to create a disbursement' do
    it 'persists the disbursement properly' do
      disbursement = Disbursement.new({
        merchant_id: 1,
        disbursed_at: DateTime.now.strftime("%d/%m/%Y %H:%M:%S"),
        amount: 2.89
      })

      DisbursementsRepository.create(disbursement, source)

      expect(DisbursementsRepository.all(source).length).to eq(1)
    end
  end

  def source
    './spec/support/dataset/disbursements.json'
  end
end
