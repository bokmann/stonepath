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
  subject_of :assignment
  
  
  
  stonepath_acl do |acl|

     acl.guard_method :save
     acl.guard_method :name=
     acl.guard_method :name
     acl.guard_method :regarding=
     acl.guard_method :regarding

     acl.method_group :modifiers, [:save, :name=, :regarding=]
     acl.method_group :accessors, [:name, :regarding]

     acl.for_state :in_process do |state|
       state.access_for_role :manager do |role|
         role.allow_method :name
       end

       state.access_for_role :peon do |role|
         role.deny_method :name=
         role.deny_method :regarding=
       end

       state.access_for_role :assistant_manager do |role|
         role.check_method_access :method_symbol do
           return false
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
   
   
end
