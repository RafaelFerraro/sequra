Sequel.migration do
  change do
    create_table(:orders) do
      primary_key :id
      foreign_key :merchant_id, :merchants, null: false
      String :shopper_id, null: false
      BigDecimal :amount, null: false
      DateTime :created_at
      DateTime :completed_at
    end
  end
end
