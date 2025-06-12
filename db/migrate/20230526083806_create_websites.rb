class CreateWebsites < ActiveRecord::Migration[7.0]
  def change
    create_table :websites do |t|
      t.string :domain, null: false
      t.string :token, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
    add_index :websites, :token, unique: true
  end
end
