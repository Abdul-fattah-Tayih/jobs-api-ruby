# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, to: :cr
    can :read, JobPost, public: true
    
    if user.present?
      can :create, JobApplication

      if user.admin?
        can :manage, JobPost
        can :cr, User
        can :cr, JobApplication
      end
    end
  end
end
