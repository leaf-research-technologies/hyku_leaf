# frozen_string_literal: true

module Importer
  module Factory
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :ConferenceItemFactory
      autoload :ObjectFactory
      autoload :StringLiteralProcessor
      autoload :JournalArticleFactory
      autoload :PublishedWorkFactory
      autoload :BaseFactory
    end

    # @param [#to_s] First (Xxx) portion of an "XxxFactory" constant
    def self.for(model_name)
      const_get "#{model_name}Factory"
    end
  end
end