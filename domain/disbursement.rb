require 'securerandom'
require 'date'

class Disbursement
  attr_reader :id, :merchant_id, :disbursed_at, :amount

  def self.create_from_order(order, calculate_fee = CalculateFee.new)
    new(
      merchant_id: order["merchant_id"],
      disbursed_at: DateTime.now,
      amount: calculate_fee.calculate_for_amount(order["amount"])
    )
  end

  def initialize(attributes = {})
    @id = attributes.fetch(:id, SecureRandom.uuid)
    @merchant_id = attributes.fetch(:merchant_id)
    @disbursed_at = attributes.fetch(:disbursed_at)
    @amount = attributes.fetch(:amount)
  end

  def to_h
    {
      id: @id,
      merchant_id: @merchant_id,
      disbursed_at: @disbursed_at,
      amount: @amount
    }
  end
end
