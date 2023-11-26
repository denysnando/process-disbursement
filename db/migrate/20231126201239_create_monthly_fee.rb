class CreateMonthlyFee < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_fees do |t|
      t.references :merchant, index: true
      t.integer :year
      t.integer :month
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
