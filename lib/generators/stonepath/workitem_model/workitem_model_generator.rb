require 'generators/stonepath'

module Stonepath
  module Generators
    class WorkitemModelGenerator < Base
      include Rails::Generators::Migration
         
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      
      def create_model_file
        template('model.rb', "app/models/#{file_name}.rb") if valid_model_name?(file_name)
      end
      
      def create_migration
        migration_template 'migration.rb', "db/migrate/create_#{file_name.pluralize}.rb"
      end
      
      protected  

      def valid_model_name?(name)
        (name =~ /("|'|:|;|\||&|<|>)/).nil? 
      end
      
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
