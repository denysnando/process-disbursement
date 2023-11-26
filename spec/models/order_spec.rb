# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe '#net_amount' do
    it 'calculates the net amount correctly' do
      order = create(:order, amount: 100.0)
      allow(order).to receive(:calculate_fee_amount).and_return(1.0)

      expect(order.net_amount).to eq(99.0)
    end
  end

  describe '#calculate_fee_amount' do
    it 'calculates the fee amount correctly' do
      order = build(:order, amount: 100.0)
      allow(order).to receive(:fee_percentage).and_return(0.01)

      expect(order.calculate_fee_amount).to eq(1.0)
    end
  end

  describe '#fee_percentage' do
    it 'returns the correct fee percentage for Tier 1' do
      order = build(:order, amount: Order::TIER_1_LIMIT - 1)

      expect(order.fee_percentage).to eq(Order::TIER_1_FEE)
    end

    it 'returns the correct fee percentage for Tier 2' do
      order = build(:order, amount: Order::TIER_2_LIMIT - 1)

      expect(order.fee_percentage).to eq(Order::TIER_2_FEE)
    end

    it 'returns the correct fee percentage for Tier 3' do
      order = build(:order, amount: Order::TIER_2_LIMIT + 1)

      expect(order.fee_percentage).to eq(Order::TIER_3_FEE)
    end
  end
end
