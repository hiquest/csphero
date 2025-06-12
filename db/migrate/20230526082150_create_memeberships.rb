class CreateMemeberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memeberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :role, null: false, default: 'regular'

      t.timestamps
    end
  end
end
