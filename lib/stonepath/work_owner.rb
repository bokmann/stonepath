module StonePath
  module WorkOwner
    def self.included(base)
      base.instance_eval do
        def workowner_for(work_items)
          has_many work_items
        end
      end
    end
  end
end