module StonePath
  module ControllerHooks
    def self.included(base)
      base.instance_eval do
        before_filter do |c|
          ActiveRecord::Base.current_user = current_user
        end 
      end
    end
  end
end