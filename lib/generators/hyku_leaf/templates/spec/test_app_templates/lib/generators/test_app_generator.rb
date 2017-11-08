        require 'rails/generators'

        class TestAppGenerator < Rails::Generators::Base
          source_root "./spec/test_app_templates"

          # if you need to generate any additional configuration
          # into the test app, this generator will be run immediately
          # after setting up the application

          def install_hyrax
            gem 'hyrax', '2.0.0.rc2'
            run 'bundle install'
            generate 'hyrax:install', '-f'
            rails_command 'db:migrate'
          end

          def install_dog_biscuits
            gem 'dog_biscuits', :git => 'https://github.com/ULCC/dog_biscuits', branch: 'hyrax2'
            generate 'dog_biscuits:install', '-f'
            generate 'dog_biscuits:work ConferenceItem', '-f'
            generate 'dog_biscuits:work PublishedWork ', '-f'
          end

          # Fix for running on vagrant on windows with nfs
          def configure_tmp_directory
            if ENV['USER'] == 'vagrant'
              injection = "\n  # Relocate RAILS_TMP"
              injection += "\n  config.assets.configure do |env|"
              injection += "\n    env.cache = Sprockets::Cache::FileStore.new("
              injection += "\n      ENV['RAILS_TMP'] + '/cache/assets'"
              injection += "\n    )"
              injection += "\n  end if ENV['RAILS_TMP']"

              inject_into_file 'config/application.rb', after: '# -- all .rb files in that directory are automatically loaded.' do
                injection
              end
            # assumes use of rbenv
              run 'touch .rbenv-vars'
              run 'echo "RAILS_TMP=/tmp" >> .rbenv-vars'
              run 'rbenv vars'
            end
          end
          # end of methods running only on localhost

          # def install_engine
          #   generate 'hyku_leaf:install'
          # end

          def install_eprints_importer
            generate 'hyku_leaf:importers'
          end

        end
