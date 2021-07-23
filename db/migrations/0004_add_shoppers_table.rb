Sequel.migration do
  change do
    create_table(:shoppers) do
      uuid :id, primary_key: true
      String :name, null: false
      String :email, null: true
      String :nif, null: false
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
