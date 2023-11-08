class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post # start by defining rules for all users, also not logged ones
    return unless user.present?

    # if the user is logged in can create posts, comments and likes
    can :create, Post
    can :create, Comment
    can :create, Like

    can :destroy, Post, author_id: user.id # if the user is logged in can delete it's own posts
    can :destroy, Comment, user_id: user.id # if the user is logged in can delete it's own comments
    can :destroy, Like, user_id: user.id # if the user is logged in can delete it's own likes
    return unless user.role == 'admin'

    can :manage, :all # give all remaining permissions only to the admins

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
