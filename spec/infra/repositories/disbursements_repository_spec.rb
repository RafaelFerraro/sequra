require 'date'
require './domain/disbursement'
require './infra/repositories/disbursements_repository'

RSpec.describe DisbursementsRepository do
  context 'when asking to create a list of disbursements' do
    it 'adds all of them properly' do
      disbursements = [
        Disbursement.new({
          merchant_id: 1,
          disbursed_at: DateTime.now.strftime("%d/%m/%Y %H:%M:%S"),
          amount: 2.89
        }),
        Disbursement.new({
          merchant_id: 2,
          disbursed_at: DateTime.now.strftime("%d/%m/%Y %H:%M:%S"),
          amount: 1.49
        })
      ]

      DisbursementsRepository.create_in_batch(disbursements)

      expect(DisbursementsRepository.all.length).to eq(2)
    end
  end
end
