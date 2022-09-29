FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    work_id               { Faker::Number.between(from: 2, to: 4) }
    profile_text          { Faker::Lorem.sentence }

    after(:build) do |user|
      user.profile_image.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
