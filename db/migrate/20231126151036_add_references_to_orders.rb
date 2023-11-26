class AddReferencesToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :disbursement, index: true
  end
end
