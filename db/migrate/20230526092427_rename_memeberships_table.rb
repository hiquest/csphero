class RenameMemebershipsTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :memeberships, :memberships
  end
end
