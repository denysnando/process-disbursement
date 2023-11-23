class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.string :merchant_reference
      t.string :identifier, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
