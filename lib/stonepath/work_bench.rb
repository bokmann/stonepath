module StonePath
  module WorkBench
    def self.included(base)
      base.instance_eval do
        def workbench_for(tasks, options={})
          has_many tasks, :as => :workbench
        end
      end
    end
  end
end