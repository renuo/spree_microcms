# TODO: autoload does not work yet for the SpreeMicrocms module together with Spree!
# hence, after modifying e.g. a model rails crashes :,(
# hence we dont use SpreeMicrocms.base_controller for now ...

# should not be required, since we have lib added to autoload_paths, rails should require lib/micro_cms automatically
# in production env, everything in autoload_path is eager_loaded, and not modified during operation :) => no need to
# reload.

# load 'lib/spree_microcms.rb' if Rails.env.development?

module SpreeMicrocms
  module Admin
    class PagesController < ::Spree::Admin::BaseController
      before_action :find_resource, only: [:edit, :update, :destroy]

      def index
        @pages = SpreeMicrocms::Page.all
      end

      def new
        @page = SpreeMicrocms::Page.new
      end

      def create
        @page = SpreeMicrocms::Page.new(page_params)
        if @page.save
          flash[:success] = flash_message_for(@page, :successfully_created)
          redirect_to collection_url
        else
          respond_with @page
        end
      end

      def edit
      end

      def update
        if @page.update(page_params)
          flash[:success] = flash_message_for(@page, :successfully_updated)
          redirect_to collection_url
        else
          respond_with @page
        end
      end

      def update_positions
        params[:positions].each_with_index do |position, index|
          SpreeMicrocms::Page.where(id: position[0].to_i).update_all(order: index, updated_at: Time.now)
        end

        respond_to do |format|
          format.js { render text: 'Ok' }
        end
      end

      def destroy
        if @page.destroy
          flash[:success] = flash_message_for(@page, :successfully_removed)
          respond_with(@page) do |format|
            format.html { redirect_to collection_url }
            format.js { render_js_for_destroy }
          end
        end
      end

      def collection_url
        admin_pages_path
      end

      helper_method :collection_url

      private

      def find_resource
        @page ||= ::SpreeMicrocms::Page.find(params[:id])
      end

      def page_params
        params.require(:page).permit(:key, :presentation, :parent_id)
      end
    end
  end
end
