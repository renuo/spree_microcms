require 'cancan'
class Ckeditor::Hooks::SpreeCanCanAuthorization < Ckeditor::Hooks::CanCanAuthorization
  # use Spree::Ability by default
  def initialize(controller, ability = Spree::Ability)
    super
  end
end
