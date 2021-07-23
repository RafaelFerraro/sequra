Sequel.migration do
  change do
    create_table(:orders) do
      uuid :id, primary_key: true
      uuid :merchant_id, foreign_key: :merchants, null: false
      uuid :shopper_id, foreign_key: :shoppers, null: false
      BigDecimal :amount, null: false
      DateTime :created_at
      DateTime :completed_at
    end
  end
end
