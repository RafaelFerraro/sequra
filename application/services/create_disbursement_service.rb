require './infra/repositories/disbursements_repository'
require './infra/repositories/orders_repository'
require './domain/disbursement'

class CreateDisbursementService
  def initialize(overrides = {})
    @orders_repository = overrides.fetch(:orders_repository) do
      OrdersRepository.new
    end
    @disbursements_repository = overrides.fetch(:disbursements_repository) do
      DisbursementsRepository
    end
    @disbursement = overrides.fetch(:disbursement) do
      Disbursement
    end
  end

  def create
    completed_orders = @orders_repository.find_week_completed_orders

    completed_orders.each do |order|
      @disbursements_repository.create(
        @disbursement.create_from_order(order)
      )
    end
  end
end
