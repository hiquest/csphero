class AddOriginalPolicyToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :original_policy, :text
  end
end
