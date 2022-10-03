FactoryBot.define do
  factory :project do
    name          { Faker::Lorem.sentence }
    about         { Faker::Lorem.paragraph(sentence_count: 5) }
    project_start { Faker::Date.between(from: 40.days.ago, to: Date.tomorrow) }
    project_end   { project_start + 7 }
    member_flag   { Faker::Number.between(from: 0, to: 1) }

    after(:build) do |project|
      project.files.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
