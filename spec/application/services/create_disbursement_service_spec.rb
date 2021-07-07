require './application/services/create_disbursement_service'

RSpec.describe CreateDisbursementService do
  it 'creates disbursements for completed orders' do
    orders_repository = double(:orders_repository)
    disbursements_repository = spy(:disbursements_repository)
    disbursement_class = class_double(Disbursement)
    disbursement = instance_double(Disbursement)
    order = double(:order)
    completed_orders = [order]
    allow(orders_repository).to receive(:find_week_completed_orders).and_return(completed_orders)
    allow(disbursement_class).to receive(:create_from_order).with(order).and_return(disbursement)

    described_class.new(
      orders_repository: orders_repository,
      disbursements_repository: disbursements_repository,
      disbursement: disbursement_class
    ).create

    expect(disbursements_repository).to have_received(:create).with(disbursement)
  end
end
