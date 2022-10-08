FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.paragraph(sentence_count: 5) }
    association :user
    association :project
  end
end
