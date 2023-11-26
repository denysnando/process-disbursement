class CreateDisbursements < ActiveRecord::Migration[7.1]
  def change
    create_table :disbursements do |t|
      t.references :merchant, index: true
      t.decimal :amount, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :amount_without_tax, null: false, default: 0.00, precision: 10, scale: 2
      t.integer :year
      t.integer :week
      t.string :reference

      t.timestamps
    end
  end
end
