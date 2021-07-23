Sequel.migration do
  change do
    create_table(:disbursements) do
      uuid :id, primary_key: true
      uuid :order_id, foreign_key: :orders, null: false
      BigDecimal :amount, null: false
      DateTime :disbursed_at
      DateTime :updated_at
    end
  end
end
