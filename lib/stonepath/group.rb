# This is a concept that existed in the older Journeyman workflow engine, but I'm not sure
# that StonePath needs it.  It is proving more worthwhile to ust rely on any number of other
# active_record models for providing group functionality, and you can see this id pretty much
# an empty stub.

# Groups were another aggregation of work much like users were.  With the general concept of
# WorkBench, I think this will be leaving the framework soon.
# -db!

module StonePath
  module Group
    def self.included(base)
      base.instance_eval do
        
      end
    end
  end
end