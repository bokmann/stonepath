require 'generators/stonepath'

module Stonepath
  module Generators
    class EventLogGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      def self.source_root
            @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end
      
      def create_model_file
        template('event_record.rb', "app/models/event_record.rb")
      end
      
      def create_migration
        migration_template 'create_event_records.rb', "db/migrate/create_event_records.rb"
      end
      
      protected
      
      # Implement the required interface for Rails::Generators::Migration.
      # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
    end
  end
end
