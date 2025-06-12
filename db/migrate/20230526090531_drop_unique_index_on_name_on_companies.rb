class DropUniqueIndexOnNameOnCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_index :companies, :name
  end
end
