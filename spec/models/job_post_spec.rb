require 'rails_helper'

RSpec.describe JobPost, type: :model do
  it 'is valid with valid attributes' do
    job_post = FactoryBot.build(:job_post)
    expect(job_post).to be_valid
  end
  it 'is not valid without a title' do
    job_post = FactoryBot.build(:job_post, { title: nil })
    expect(job_post).to_not be_valid
  end
  it 'is not valid without a description' do
    job_post = FactoryBot.build(:job_post, { description: nil })
    expect(job_post).to_not be_valid
  end
  it 'is not valid without expires_at' do
    job_post = FactoryBot.build(:job_post, { expires_at: nil })
    expect(job_post).to_not be_valid
  end

  it 'is not valid with a title that is longer than 255 chars' do
    job_post = FactoryBot.build(:job_post, { title: SecureRandom.alphanumeric(256) })
    expect(job_post).to_not be_valid
  end

  it 'is not returned when the expiry date is less than today' do
    FactoryBot.create(:job_post, { expires_at: DateTime.now - 1.day })
    expect(JobPost.all).to be_empty
  end
end
