# frozen_string_literal: true

class ProcessDisbursementsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    current_day_of_week = Date.current.wday

    merchants = Merchant.where(
      "disbursement_frequency = 'DAILY' OR
       (disbursement_frequency = 'WEEKLY' AND
        EXTRACT(DOW FROM live_on::timestamp) = ?)",
      current_day_of_week
    )

    merchants.each do |merchant|
      orders = Order.incompleted.where(merchant_reference: merchant.reference)
      ProcessDisbursements.call(orders:, merchant:)
    end
  end
end
