require 'generators/stonepath'

module Stonepath
  module Generators
    class WorkitemModelGenerator < Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      
      def generate
        puts "not yet implemented"
      end
      
    end
  end
end
