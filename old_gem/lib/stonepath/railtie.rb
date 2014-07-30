require 'stonepath'
require 'rails'

module StonePath
  class Railtie < Rails::Railtie

    rake_tasks do
      load "tasks/stonepath.rake"
    end
  end
end