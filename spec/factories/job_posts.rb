FactoryBot.define do
  factory :job_post do
    title Faker::Job.title
    description Faker::Lorem.paragraph
    expires_at DateTime.now + 1.weeks
  end
end
