module SpreeMicrocms
  module ApplicationHelper
    def method_missing(method, *args, &block)
      if method.to_s.end_with?('_path', '_url')
        if spree.respond_to?(method)
          spree.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

    def cms_slug_path_by_key(key)
      cache = SpreeMicrocms::PathCache
      unless cache.paths.key? key
        slug = ::SpreeMicrocms::Page.predefined(key).slug
        cache.set_path(key, cms_url_helper_lookup(:cms_slug_path, slug))
      end
      cache.paths[key]
    end

    def cms_page_active_current(key)
      cms_page_active(key, request.path)
    end

    def cms_page_in_trail_current(key)
      cms_page_in_trail(key, request.path)
    end

    def cms_nav_classes(key)
      nav_classes_private(key, request.path)
    end

    def page_by_path(url_path)
      page_by_path_private url_path
    end

    # overwrite in your project if required
    def cms_url_helper_lookup(path_helper, *args)
      # main_app is required if helper is invoked from within spree template
      if main_app && defined?(Spree)
        main_app.send path_helper.to_sym, *args
      else
        send path_helper.to_sym, *args
      end
    end

    def cms_breadcrumb(page)
      crumbs = [content_tag(:li, link_to(t('home'), root_path))]
      crumbs << page.ancestors_and_self.map do |p|
        content_tag(:li, link_to(p.presentation, cms_slug_path_by_key(p.key)))
      end
      crumb_list = content_tag(:ol, raw(crumbs.flatten.map(&:mb_chars).join), class: 'breadcrumb')
      content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'col-md-12')
    end

    private

    def nav_classes_private(key, request_path)
      Rails.cache.fetch("#{key}-#{request_path}-pages-nav-classes", expires_in: 1.week) do
        [cms_active_class(key, request_path), cms_trail_class(key, request_path)].join(' ')
      end
    end

    def cms_page_active(key, request_path)
      Rails.cache.fetch("#{key}-#{request_path}-pages-active", expires_in: 1.week) do
        page = page_by_path_private(request_path)
        page && page.key == key
      end
    end

    def cms_page_in_trail(key, request_path)
      Rails.cache.fetch("#{key}-#{request_path}-pages-trail", expires_in: 1.week) do
        page = page_by_path_private(request_path)
        page && page.ancestors.map(&:key).include?(key)
      end
    end

    def cms_active_class(key, request_path)
      cms_page_active(key, request_path) ? 'active' : ''
    end

    def cms_trail_class(key, request_path)
      cms_page_in_trail(key, request_path) ? 'active trail' : ''
    end

    def page_by_path_private(url_path)
      Rails.cache.fetch("#{url_path}-pages-by-path", expires_in: 1.week) do
        ::SpreeMicrocms::PageCache.pages.find do |p|
          rest_path = cms_url_helper_lookup :micro_cms_page_path, p
          slug_path = cms_slug_path_by_key(p.key)
          url_path == rest_path || url_path == slug_path
        end
      end
    end
  end
end
