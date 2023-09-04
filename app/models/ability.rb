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

      can :create,Rating do |post|
        user.ratings.where(post_id: post.post_id).count.zero?
      end
      unless user.ratings.empty?
        cannot :create, Rating
      end

    end
  end
end
