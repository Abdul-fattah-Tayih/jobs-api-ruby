# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  enum role: %i[user admin]
  after_initialize :set_default_role, ** { if: :new_record? }
  has_many :job_applications
  def set_default_role
    self.role ||= :user
  end
end
