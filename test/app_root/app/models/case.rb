class Case < ActiveRecord::Base
  include StonePath
  
  stonepath_workitem
  
  aasm_initial_state :pending

  aasm_state :pending
  aasm_state :in_process
  aasm_state :completed

  aasm_event :complete do
    transitions :to => :completed, :from => :in_process
  end

  aasm_event :activate do
    transitions :to => :in_process, :from => :pending
  end
  
  owned_by :user
  tasked_through :assignments
  
  
  #other thoughts -
  # I might want to pull acl out into its own gem.
  # If I do, then the acl.for_state will get complicated.
  # I might make it something that can be modeled like this:
  #
  # acl.for_field(:aasm_state).has_value("in_process") do
  # end
  #
  # which would make this a *lot* more reusable in different
  # contexts.
  
  # -
  # I think there is scizophrenia caused by the framework not
  # committing to "deny unless access allowed" vs. "allow unless
  # access denied".  I think the principal of least surprise would
  # dictate we allow unless specifically denied, and I'm almost
  # ready to commit to that.
  
  # -
  # There are also issues when a use has one role vs. many roles.
  # When there is one role, things are easy.
  # When they have multiple roles, do we deny if _any_ of them are
  # denied, or allow unless _all_ are denied?  I think POLS would
  # say allow unless all denied... but then, which return block do
  # we return?  PErhaps something simple like "the first one defined". 
  stonepath_acl do |acl|

     acl.guard_method :save
     acl.guard_method :name=
     acl.guard_method :name
     acl.guard_method :regarding=
     acl.guard_method :regarding
     acl.guard_method :description
     acl.guard_method :description=
     acl.method_group :modifiers, [:save, :name=, :regarding=, :description=]
     acl.method_group :accessors, [:name, :regarding, :description]

     acl.for_state :in_process do |state|
       state.access_for_role :manager do |role|
         role.allow_method :name
       end

       state.access_for_role :peon do |role|
         role.deny_method :name=
         role.deny_method :regarding=
         role.deny_method(:description) {  #value of block is returned.  might this need to be a proc?
           "You do not have access to look at the description, you peon!"
         }
       end

       state.access_for_role :assistant_manager do |role|
         role.check_method_access :method_symbol do
           # you can implement conditional logic here.
           # maybe you want to defer the true/false
           # access decision and check some attribute of
           # the user.
           return false #your conditional answer.
         end
       end
     end

     acl.for_state :completed do |state|
       state.access_for_role :manager do |role|
         role.deny_method_group :modifiers
       end

       state.access_for_role :peon do |role|
         role.deny_method_group :modifiers
         role.deny_method_group :accessors
       end

     end
   end
   

   def task_created(task)
     self.notification_method = "created"
     self.notified_id = task.id
     self.save
   end
   
   def task_closed(task)
     self.notification_method = "closed"
     self.notified_id = task.id
     self.save
   end

end
