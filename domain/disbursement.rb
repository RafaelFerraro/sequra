require 'securerandom'

class Disbursement
  attr_reader :id, :merchant_id, :disbursed_at, :amount

  def initialize(attributes = {})
    @id = attributes.fetch(:id, SecureRandom.uuid)
    @merchant_id = attributes.fetch(:merchant_id)
    @disbursed_at = attributes.fetch(:disbursed_at)
    @amount = attributes.fetch(:amount)
  end
end
