FactoryBot.define do
  factory :schedule do
    title      { Faker::Lorem.sentence }
    start_date { Faker::Date.between(from: Date.today, to: '2022-12-01') }
    end_date   { start_date + 7 }
    work_id    { Faker::Number.between(from: 2, to: 4) }
    association :project
  end
end
