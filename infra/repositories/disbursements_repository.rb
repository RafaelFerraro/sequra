class DisbursementsRepository
  @@disbursements = []

  def self.create_in_batch(disbursements)
    disbursements.each { |disbursement| @@disbursements << disbursement }
  end

  def self.all
    @@disbursements
  end
end
