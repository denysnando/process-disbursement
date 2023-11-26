# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ProcessDisbursementsWorker, type: :worker do
  let(:daily_merchant) { create(:merchant, disbursement_frequency: 'DAILY') }
  let(:weekly_merchant) { create(:merchant, disbursement_frequency: 'WEEKLY', live_on: Date.current) }
  let(:order1) { create(:order, merchant_reference: daily_merchant.reference) }
  let(:order2) { create(:order, merchant_reference: weekly_merchant.reference) }

  describe '#perform' do
    it 'processes disbursements for eligible merchants' do
      expect(described_class.jobs.size).to eq(0)

      expect(ProcessDisbursements).to receive(:call).with(orders: [order1], merchant: daily_merchant)
      expect(ProcessDisbursements).to receive(:call).with(orders: [order2], merchant: weekly_merchant)

      described_class.new.perform
    end
  end
end
