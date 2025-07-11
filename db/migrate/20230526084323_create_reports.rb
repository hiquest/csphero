class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :website, null: false, foreign_key: true
      t.text :raw_headers
      t.jsonb :raw_body

      t.timestamps
    end
  end
end
