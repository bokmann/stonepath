# for the ACL stuff to work, models need to know who the current user is.
# This adds a current_user to ActiveRecord
unless ActiveRecord::Base.respond_to?(:current_user)
  class ActiveRecord::Base
    cattr_accessor :current_user
  end
end