class DisbursementsRepository
  @@disbursements = []

  def self.create(disbursement)
    @@disbursements << disbursement
  end

  def self.all
    @@disbursements
  end
end
