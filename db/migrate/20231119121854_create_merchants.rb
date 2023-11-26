class CreateMerchants < ActiveRecord::Migration[7.1]
  def change
    create_table :merchants do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :reference, null: false, index: { unique: true }
      t.date :live_on, null: false
      t.string :disbursement_frequency
      t.decimal :minimum_monthly_fee, precision: 10, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
