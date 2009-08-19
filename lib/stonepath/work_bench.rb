module StonePath
  module WorkBench
    def self.included(base)
      base.instance_eval do
        def workbench_for(tasks)
          has_many tasks, :foreign_key => :assignee_id
        end
      end
    end
  end
end