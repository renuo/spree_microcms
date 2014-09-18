module SpreeMicrocms
  module Cacheable
    extend ActiveSupport::Concern

    def self.included(klass)
      klass.instance_eval do
        scope :most_recently_updated, -> { reorder('updated_at DESC') }
      end
    end
  end
end
