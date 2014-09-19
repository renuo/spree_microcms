# to be defined for each project
module SpreeMicrocms
  class AbilityDecorator
    include CanCan::Ability

    def initialize(user)
      if user.respond_to?(:has_spree_role?) && user.has_spree_role?('admin')
        can :manage, :all
        can :access, :ckeditor
      else
        can :read, SpreeMicrocms::Page
      end
    end
  end

  Spree::Ability.register_ability(AbilityDecorator)
end
