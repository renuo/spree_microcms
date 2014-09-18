# TODO autoload does not work yet for the SpreeMicrocms module together with Spree! hence, after modifying e.g. a model rails crashes :,(
# hence we dont use SpreeMicrocms.base_controller for now ...

# should not be required, since we have lib added to autoload_paths, rails should require lib/micro_cms automatically
# in production env, everything in autoload_path is eager_loaded, and not modified during operation :) => no need to reload
load 'lib/spree_microcms.rb' if Rails.env.development?

module SpreeMicrocms S
  class PagesController <  SpreeMicrocms::ApplicationController

    # generic routes
    def show
      @page = SpreeMicrocms::Page.find(params[:id])
    end

    def show_slug
      @page = SpreeMicrocms::PageCache.page_by_slug(params[:slug])
      render template: 'micro_cms/pages/show'
    end

    def update
      ckeditor_authorize! # throws CanCan::AccessDenied, rails will return 401
      @page = Page.find(params[:id])
      if @page.update(page_params)
        render json: {message: I18n.t('saved')}, status: 200
      else
        render json: {message: @page.errors.full_messages}, status: 400
      end
    end

    # project specific routes
    # e.g. pages with dynamically server side generated content (e.g. a toc or contact form)
    # e.g. pages with custom url (i.e. not /p/:slug or /micro_cms/pages/:id)
    def agb
      @page = SpreeMicrocms::Page.predefined('agb')
      render template: 'micro_cms/pages/show'
    end

    private
    def page_params
      params.require(:micro_cms_page).permit(:content)
    end
  end
end
