Sequel.migration do
  change do
    create_table(:merchants) do
      primary_key :id
      String :name, null: false
      String :email
      String :cif, null: false
    end
  end
end
