module Ckeditor
  class Asset < ActiveRecord::Base
    include Orm::ActiveRecord::AssetBase
    include Backend::Paperclip
  end
end
