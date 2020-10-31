require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  it 'is valid with valid attributes' do
    job_application = FactoryBot.build(:job_application)
    expect(job_application).to be_valid
  end
  it 'is not valid without a user' do
    job_application = FactoryBot.build(:job_application, { user: nil })
    expect(job_application).to_not be_valid
  end
  it 'is not valid without a description' do
    job_application = FactoryBot.build(:job_application, { job_post: nil })
    expect(job_application).to_not be_valid
  end
end
