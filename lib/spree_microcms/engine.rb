module SpreeMicrocms
  class Engine < ::Rails::Engine
    isolate_namespace SpreeMicrocms

    initializer 'spree_microcms.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper SpreeMicrocms::ApplicationHelper
      end
    end
  end
end
