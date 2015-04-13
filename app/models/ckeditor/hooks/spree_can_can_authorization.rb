require 'cancan'

module Ckeditor
  module Hooks
    class SpreeCanCanAuthorization < CanCanAuthorization
      # use Spree::Ability by default
      def initialize(controller, ability = Spree::Ability)
        super
      end
    end
  end
end
