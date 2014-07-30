require 'rails/generators/named_base'

module Stonepath
  module Generators
    class Base < Rails::Generators::NamedBase
      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'stonepath', generator_name, 'templates'))        
      end
    end
  end
end