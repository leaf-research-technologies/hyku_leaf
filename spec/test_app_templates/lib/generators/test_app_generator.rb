require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "./spec/test_app_templates"

  # if you need to generate any additional configuration
  # into the test app, this generator will be run immediately
  # after setting up the application

  def install_hyrax
    gem 'hyrax', '>= 2', '< 3'
    run 'bundle install'
    generate 'hyrax:install', '-f'
    rails_command 'db:migrate'
  end

  def install_dog_biscuits
    gem 'dog_biscuits'
    generate 'dog_biscuits:install', '-f'
    generate 'dog_biscuits:work ConferenceItem', '-f'
    generate 'dog_biscuits:work PublishedWork ', '-f'
    generate 'dog_biscuits:work JournalArticle ', '-f'
  end

  # Fix for running on vagrant on windows with nfs
  def configure_tmp_directory
    if ENV['USER'] == 'vagrant'
      injection = "\n    # Relocate RAILS_TMP"
      injection += "\n    config.assets.configure do |env|"
      injection += "\n      env.cache = Sprockets::Cache::FileStore.new("
      injection += "\nENV['RAILS_TMP'] + '/cache/assets'"
      injection += "\n      )"
      injection += "\n    end if ENV['RAILS_TMP']"

      inject_into_file 'config/application.rb', after: '# -- all .rb files in that directory are automatically loaded.' do
injection
      end

      run 'export RAILS_TMP=/TMP'
    end
  end
  # end of methods running only on localhost

  def install_eprints_importer
    generate 'leaf_addons:importers'
  end
  
  def install_coversheet
    generate 'leaf_addons:coversheet'
  end
  
  def install_oai_pmh
    generate 'leaf_addons:oai_pmh'
  end
end