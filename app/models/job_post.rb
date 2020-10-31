class JobPost < ApplicationRecord
  has_many :job_applications
  validates :title, length: { maximum: 255 }, presence: true
  validates_presence_of :description
  validates_presence_of :expires_at
  validates_associated :job_applications

  # By default, only load job posts that are not expired
  default_scope { where('expires_at > ?', DateTime.now) }
end
