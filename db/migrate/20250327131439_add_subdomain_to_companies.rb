class AddSubdomainToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :subdomain, :string
    add_index :companies, :subdomain, unique: true
  end
end
