class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_post

  validates_presence_of :user
  validates_presence_of :job_post
end
