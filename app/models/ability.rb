class Ability
  include CanCan::Ability

  def initialize(user)
    if true
      can :update, Post do |post|
        post.user == user
      end

      can :destroy, Post do |post|
        post.user == user
      end

      can :destroy,  Comment do |post|
        post.user == user
      end

      can :create, Post
      can :create, Comment

      can :create, Rating

    end
  end
end
