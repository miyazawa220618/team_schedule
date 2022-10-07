FactoryBot.define do
  factory :share do
    share_date { Faker::Date.between(from: 40.days.ago, to: Date.tomorrow) }
    hour_id    { 50 }
    memo       { Faker::Lorem.paragraph(sentence_count: 5) }
    association :user
    association :schedule

    after(:build) do |share|
      share.memo_files.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
