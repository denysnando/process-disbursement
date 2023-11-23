class CreateDisbursements < ActiveRecord::Migration[7.1]
  def change
    create_table :disbursements do |t|
      t.decimal :amount_disbursed, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :amount_of_orders, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :amount_monthly_fee_charged, null: false, default: 0.00, precision: 10, scale: 2

      t.integer :counter_disbursed
      t.integer :counter_monthly_fee_charged
      t.integer :year

      t.timestamps
    end
  end
end
