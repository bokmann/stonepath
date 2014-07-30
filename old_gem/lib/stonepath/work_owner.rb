# every WorkItem has one and exactly one owner.  In some domains, WorkOwners and WorkBenches will
# be the same thing, but in other domains they are separate concepts.  the owner is 'responsible'
# for the WorkItem in a larger sense - but the WorkBenches are 'responsible' for the completion of
# tasks associated with the WorkItem.
#
# This separation allows workflows where the owner assigns out work, and may oe may not be
# responsible for the actual completion of the work.
module StonePath
  module WorkOwner
    def self.included(base)
      base.instance_eval do
        def workowner_for(work_items, options={})
          options.merge!(:foreign_key => :owner_id)
          has_many work_items, options
        end
      end
    end
  end
end