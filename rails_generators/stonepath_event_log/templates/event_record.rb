class EventRecord < ActiveRecord::Base
  belongs_to :auditable, :polymorphic => true  
  
  # the user_id field will point to the id of the current_user set by the controller
  # hack.  feel free to add our own finder here using that.
end