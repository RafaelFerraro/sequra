class CalculateFee
  def calculate_for_amount(amount)
    (amount * (fee_value_for_amount(amount)/100)).round(2)
  end

  private

  def fee_value_for_amount(amount)
    {
      (0..49.99) => 1.0,
      (50..300.99) => 0.95,
      (301..Float::INFINITY) => 0.85
    }.select { |range| range.include?(amount) }.values.first
  end
end
