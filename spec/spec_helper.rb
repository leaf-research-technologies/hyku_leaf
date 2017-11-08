# frozen_string_literal: true

# spec/spec_helper.rb
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.internal_test_app'
end

# coveralls
require 'coveralls'
Coveralls.wear!

# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# as of webmock v2 this has to go here, after load path and before other requires
require 'webmock/rspec'
require 'factory_bot_rails'
require 'engine_cart'

EngineCart.load_application!

# JA check which of these are actually needed
require 'byebug' unless ENV['TRAVIS']
require 'jquery-rails'
require 'coffee-rails'
require 'bootstrap-sass'
require 'turbolinks'
require 'sqlite3'
require 'devise'
require 'listen'
require 'rake'

WebMock.disable_net_connect!(allow_localhost: true)

# Are these needed?
FactoryBot.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryBot.find_definitions

#require 'support/factory_bot'
require 'active_fedora/cleaner'
RSpec.configure do |config|

  # spec/support/factory_bot.rb
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
  config.before(:suite) do
    # nothing to do here
  end
  config.before(:each) do
    # nothing to do here
  end
  config.after(:suite) do
    ActiveFedora::Cleaner.clean!
  end
  # Include shared examples for concerns
  Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
end