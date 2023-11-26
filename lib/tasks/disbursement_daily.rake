# frozen_string_literal: true

namespace :disbursement do
  desc 'Disbursement daily events'

  task process_disbursement: [:environment] do
    ProcessDisbursementsWorker.perform_async
  end
end
