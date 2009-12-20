module StonePath
  module WorkBench
    def self.included(base)
      base.instance_eval do
        def workbench_for(tasks, options={})
          #options.merge!(:foreign_key => :assignee_id)
          #puts options
          has_many tasks, :as => :workbench
        end
      end
    end
  end
end