# this 'if' test is necessary because the test app we are using doesn't load ActionView.
# of course, the correct way to fix it is to fix the test app and write some tests!
if Object.const_defined?(:ActionView)
  module ActionView
    module Helpers
      module UrlHelper
  
          def link_to_stonepath_event(object, event)
            path_method = object.class.to_s.downcase + "_event_path"
            path = self.send(path_method, object, :id => event.to_s)
            link_to(event.to_s.humanize, path, :method => :post)
          end

      end
    end
  end
end