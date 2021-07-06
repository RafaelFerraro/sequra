require './domain/calculate_fee'

RSpec.describe "Calculate disbursement" do
  context 'when amount is smaller than 50' do
    it 'returns 1% of the amount' do
      amount = 49.2

      result = CalculateFee.new.calculate_by_amount(amount)

      expect(result).to eq(0.49)
    end
  end

  context 'when amount is equal to 50' do
    it 'returns 0.95% of the amount' do
      amount = 50.0

      result = CalculateFee.new.calculate_by_amount(amount)

      expect(result).to eq(0.48)
    end
  end

  context 'when amount is greater than 50' do
    context 'but smaller than 300' do
      it 'returns 0.95% of the amount' do
        amount = 290.0

        result = CalculateFee.new.calculate_by_amount(amount)

        expect(result).to eq(2.76)
      end
    end
  end

  context 'when amount is equal to 300' do
    it 'returns 0.95% of the amount' do
      amount = 300.0

      result = CalculateFee.new.calculate_by_amount(amount)

      expect(result).to eq(2.85)
    end
  end

  context 'when amount is greater than 300' do
    it 'returns 0.85% of the amount' do
      amount = 3_000.0

      result = CalculateFee.new.calculate_by_amount(amount)

      expect(result).to eq(25.5)
    end
  end
end
