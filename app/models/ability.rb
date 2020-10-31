# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, JobPost, public: true

    if user.present?
      can :create, JobApplication
      can :read, JobApplication, user_id: user.id

      if user.admin?
        can :manage, JobPost
        can :read, User
        can :read, JobApplication
        cannot :create, JobApplication
      end
    end
  end
end
