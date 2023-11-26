# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessDisbursements, type: :model do
  let!(:merchant) { create(:merchant) }

  describe '#call' do
    context 'with orders' do
      it 'calculates and creates disbursements' do
        create_list(:order, 2, merchant_reference: merchant.reference)

        process_disbursements = described_class.new(orders: Order.all, merchant:)

        expect { process_disbursements.call }.to change(Disbursement, :count).by(2)
      end
    end

    context 'without orders' do
      it 'does not create disbursements' do
        process_disbursements = described_class.new(orders: [], merchant:)

        expect { process_disbursements.call }.not_to(change(Disbursement, :count))
      end
    end
  end

  describe 'private methods' do
    let(:process_disbursements) { described_class.new(orders: [], merchant:) }

    describe '#group_orders_by_month' do
      it 'groups orders by month' do
        order1 = double(created_at: 2.months.ago)
        order2 = double(created_at: 1.month.ago)

        process_disbursements.instance_variable_set(:@orders, [order1, order2])

        result = process_disbursements.send(:group_orders_by_month)

        expect(result.keys).to contain_exactly(
          order1.created_at.beginning_of_month, order2.created_at.beginning_of_month
        )
      end
    end

    describe '#calculate_disbursements' do
      it 'calls process_monthly_fee and create_disbursement for each month and order' do
        order1 = double(created_at: 2.months.ago)
        order2 = double(created_at: 1.month.ago)

        process_disbursements.instance_variable_set(:@orders, [order1, order2])

        expect(process_disbursements).to receive(:process_monthly_fee).twice
        expect(process_disbursements).to receive(:create_disbursement).twice

        process_disbursements.send(:calculate_disbursements)
      end
    end

    describe '#process_monthly_fee' do
      let(:current_month) { Time.current.beginning_of_month }

      it 'skips processing if monthly fee is already charged' do
        allow(process_disbursements).to receive(:monthly_fee_charged?).with(current_month).and_return(true)

        expect(process_disbursements).not_to receive(:calculate_total_commission_fees)
        expect(process_disbursements).not_to receive(:charge_monthly_fee)

        process_disbursements.send(:process_monthly_fee, current_month)
      end

      it 'skips processing if total commission fees are greater than or equal to minimum monthly fee' do
        allow(process_disbursements).to receive(:monthly_fee_charged?).with(current_month).and_return(false)
        allow(process_disbursements).to receive(:calculate_total_commission_fees).with(current_month).and_return(100)
        allow(merchant).to receive(:minimum_monthly_fee).and_return(100)

        expect(process_disbursements).not_to receive(:charge_monthly_fee)

        process_disbursements.send(:process_monthly_fee, current_month)
      end

      it 'charges monthly fee if conditions are met' do
        allow(process_disbursements).to receive(:monthly_fee_charged?).with(current_month).and_return(false)
        allow(process_disbursements).to receive(:calculate_total_commission_fees).with(current_month).and_return(50)
        allow(merchant).to receive(:minimum_monthly_fee).and_return(100)

        expect(process_disbursements).to receive(:charge_monthly_fee).with(current_month, 50)

        process_disbursements.send(:process_monthly_fee, current_month)
      end
    end
  end
end
