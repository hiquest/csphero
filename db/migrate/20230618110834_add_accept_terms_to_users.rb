class AddAcceptTermsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :accept_terms, :boolean
  end
end
