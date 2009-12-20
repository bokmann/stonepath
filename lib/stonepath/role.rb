# This is a concept that existed in the older Journeyman workflow engine, but I'm not sure
# that StonePath needs it.  It is proving more worthwhile to ust rely on any number of other
# gems for providing role functionality, and you can see this id pretty much an empty stub.

module StonePath
  module Role
    def self.included(base)
      base.instance_eval do

      end
    end
  end
end