module HykuLeaf
  module Importer
    module Eprints
      extend ActiveSupport::Autoload

      autoload :JsonDownloader
      autoload :JsonMapper

    end
  end
end