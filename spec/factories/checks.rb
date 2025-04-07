FactoryBot.define do
    factory :check do
      number { Faker::Number.number(digits: 6) }
      status { "pending" }
      association :company
      
      after(:build) do |check|
        check.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'bill.png')),
          filename: 'bill.png',
          content_type: 'image/png'
        )
      end
    end
  end
  