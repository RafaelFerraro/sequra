require 'sidekiq-scheduler'
require './application/services/create_disbursement_service'

class CreateDisbursementsWorker
  include Sidekiq::Worker

  def perform
    CreateDisbursementService.new.create

    p "Disbursements created!"
  end
end

