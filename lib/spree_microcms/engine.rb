module SpreeMicrocms
  class Engine < ::Rails::Engine
    isolate_namespace SpreeMicrocms
    require 'ancestry'
    require 'cancan'

    initializer 'spree_microcms.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        include Rails.application.routes.url_helpers
        helper SpreeMicrocms::ApplicationHelper
      end

      #SpreeMicrocms::ApplicationController.send(:include, Rails.application.routes.url_helpers)
    end
  end
end
