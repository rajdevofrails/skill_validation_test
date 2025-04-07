FactoryBot.define do
    factory :invoice do
      association :company
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/bill.png'), 'image/jpeg') }
      category { "Utilities" }
      status { "Pending" }
  
      # Create checks before assigning check_ids
      after(:build) do |invoice|
        checks = create_list(:check, 3)  # Ensure Check records exist
        invoice.check_ids = checks.map(&:id)
      end
    end
  end
  