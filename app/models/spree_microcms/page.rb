module SpreeMicrocms
  class Page < ActiveRecord::Base
    include ::SpreeMicrocms::Cacheable

    has_ancestry orphan_strategy: :rootify

    validates_uniqueness_of :key, case_sensitive: false
    validates_presence_of :presentation, :key

    default_scope -> { order(:ancestry, :order, :key) }
    scope :predefined, -> (key) { Page.where(key: key).first! }

    after_commit :update_cache

    def slug
      ancestors_and_self.map { |p| Page.slugify(p.presentation) }.join('/')
    end

    def self.slugify(text)
      text.parameterize
    end

    def ancestors_and_self
      ancestors << self
    end

    protected

    def update_cache
      SpreeMicrocms::PathCache.delete key
    end
  end
end
