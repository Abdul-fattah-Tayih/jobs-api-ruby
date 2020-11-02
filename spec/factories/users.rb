FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.unique.email("Email_#{n}") }
    password 'secret'
    role :user
  end

  factory :admin, class: 'User' do
    sequence(:email) { |n| Faker::Internet.unique.email("Email_#{n}") }
    password 'secret'
    role :admin
  end
end
