# frozen_string_literal: true

require 'pry'

class ProcessDisbursements
  def self.call(orders:, merchant:)
    new(orders:, merchant:).call
  end

  def initialize(orders:, merchant:)
    @orders = orders
    @merchant = merchant
  end

  def call
    calculate_disbursements
  end

  private

  attr_accessor :orders, :merchant

  def group_orders_by_month
    orders.group_by { |order| order.created_at.beginning_of_month }
  end

  def calculate_disbursements
    grouped_orders = group_orders_by_month

    grouped_orders.each do |month, orders_in_month|
      process_monthly_fee(month)

      orders_in_month.each do |order|
        create_disbursement(order)
      end
    end
  end

  def process_monthly_fee(month)
    return if monthly_fee_charged?(month)

    total_commission_fees_last_month = calculate_total_commission_fees(month)

    return unless total_commission_fees_last_month < merchant.minimum_monthly_fee

    monthly_fee_to_charge = merchant.minimum_monthly_fee - total_commission_fees_last_month

    charge_monthly_fee(month, monthly_fee_to_charge)
  end

  def monthly_fee_charged?(month)
    merchant.disbursements.exists?(year: month.year, week: month.strftime('%U').to_i)
  end

  def calculate_total_commission_fees(month)
    orders_last_month = orders.where("DATE_TRUNC('month', created_at) = ?", month)

    orders_last_month.sum { |order| order.calculate_fee_amount.to_f }
  end

  def charge_monthly_fee(month, amount)
    MonthlyFee.create!(
      merchant_id: merchant.id,
      year: month.year,
      week: month.strftime('%U').to_i,
      amount:
    )
  end

  def create_disbursement(order)
    disbursement = Disbursement.create!(
      amount: order.net_amount,
      amount_without_tax: order.amount,
      year: order.created_at.strftime('%Y').to_i,
      week: order.created_at.strftime('%U').to_i,
      merchant_id: merchant.id
    )

    order.update(disbursement_id: disbursement.id, completed_at: Time.current)
  end
end
