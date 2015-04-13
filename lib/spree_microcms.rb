require 'spree_microcms/engine'

module SpreeMicrocms
  mattr_accessor :user_class
  mattr_accessor :base_controller

  class PageCache
    def self.pages
      Rails.cache.fetch("#{key_base}-pages", expires_in: 1.week) do
        ::SpreeMicrocms::Page.all.to_a
      end
    end

    def self.page_by_slug(slug)
      pages_by_slug = Rails.cache.fetch("#{key_base}-pages-by-slug", expires_in: 1.week) do |_key|
        pages.map { |p| [p.slug, p] }.to_h
      end
      pages_by_slug[slug]
    end

    def self.key_base
      ::SpreeMicrocms::Page.most_recently_updated.first.updated_at.to_i
    end
  end

  class PathCache
    def self.paths
      Rails.cache.fetch('cms-paths', expire_in: 1.week) do
        {}
      end
    end

    def self.set_path(key, path)
      pt = paths
      pt[key] = path
      Rails.cache.write('cms-paths', pt)
    end

    def self.delete(key)
      pt = paths
      pt.delete key
      Rails.cache.write('cms-paths', pt)
    end
  end
end
