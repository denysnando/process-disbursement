require 'csv'
require 'pry'

def import_data(model_class, csv_filename)
  puts "Importing #{model_class.name.pluralize}"

  CSV.read(Rails.root.join('spec', 'fixtures', csv_filename), col_sep: ';', headers: true).each do |row|
    record = model_class.new(map_row_to_attributes(row, model_class))

    unless record.save
      puts "#{model_class.name} not created: #{row.to_hash}"
      p record.errors.full_messages
    end
  end
end

def map_row_to_attributes(row, model_class)
  if model_class == Merchant
    row.to_hash.reject { |key, _value| key.downcase == 'id' }
  else
    {
      identifier: row['id'],
      merchant_reference: row['merchant_reference'],
      amount: row['amount'].to_d,
      created_at: row['created_at']
    }
  end
end

import_data(Merchant, 'merchants.csv')
import_data(Order, 'orders.csv')
