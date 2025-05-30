class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers do |t|
      t.references :student, null: false, foreign_key: true
      t.string :school_destination
      t.date :transfer_date

      t.timestamps
    end
  end
end
