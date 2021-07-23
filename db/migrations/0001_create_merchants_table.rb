Sequel.migration do
  change do
    create_table(:merchants) do
      uuid :id, primary_key: true
      String :name, null: false
      String :email
      String :cif, null: false
    end
  end
end
