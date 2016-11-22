class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :read, Tour
      can [:create, :update, :read], User
      can :manage, Review
      can :manage, Comment, user_id: user.id
    end
  end
end
