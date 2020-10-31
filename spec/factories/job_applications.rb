FactoryBot.define do
  factory :job_application do
    association :user
    association :job_post
  end
end
