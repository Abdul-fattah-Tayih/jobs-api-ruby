FactoryBot.define do
  factory :user do
    email 'user@job-board.com'
    password 'secret'
    role :user
  end

  factory :admin, class: 'User' do
    email 'admin@job-board.com'
    password 'secret'
    role :admin
  end
end
