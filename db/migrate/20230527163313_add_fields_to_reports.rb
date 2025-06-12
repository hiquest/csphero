class AddFieldsToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :document_uri, :string
    add_column :reports, :referrer, :string
    add_column :reports, :violated_directive, :string
    add_column :reports, :effective_directive, :string
    add_column :reports, :disposition, :string
    add_column :reports, :blocked_uri, :string
    add_column :reports, :status_code, :integer
    add_column :reports, :script_sample, :text
    add_column :reports, :line_number, :integer
    add_column :reports, :column_number, :integer
    add_column :reports, :source_file, :string
  end
end
