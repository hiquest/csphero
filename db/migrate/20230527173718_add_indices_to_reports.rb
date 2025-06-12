class AddIndicesToReports < ActiveRecord::Migration[7.0]
  def change
    add_index :reports, :violated_directive
    add_index :reports, :disposition
    add_index :reports, :blocked_uri
    add_index :reports, :source_file
  end
end
