FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password 'secret'
    role :user
  end

  factory :admin, class: 'User' do
    email Faker::Internet.email
    password 'secret'
    role :admin
  end
end
