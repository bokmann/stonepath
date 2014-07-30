class Complaint < ActiveRecord::Base
  include StonePath
  
  stonepath_workitem do
    
    log_events
    
    owned_by :user
    
    tasked_through :follow_up_actions
    
    aasm_initial_state :in_creation
    
    aasm_state :in_creation
    aasm_state :cust_svc_mgr_review,
               :enter => Proc.new { |o|
                                    o.owner = User.random_user_in_role("customer_satisfaction_manager")
                                  }

    aasm_state :store_mgr_review,
               :enter => Proc.new { |o|
                                     o.complaint_type = "Minor"
                                      o.owner = o.store.manager
                                  }
    aasm_state :cust_svc_spclst_review,
               :enter => Proc.new { |o|
                                    o.complaint_type = "Intermediate"
                                    o.owner = User.random_user_in_role("customer_satisfaction_specialist")
                                  }
    
    aasm_state :attorney_review,
               :enter => Proc.new { |o|
                                    o.complaint_type = "Major"
                                    o.owner = User.random_user_in_role("corporate_attorney")
                                  }

    aasm_state :pending_action

    aasm_state :out_of_scope,
               :enter => Proc.new { |o|
                                    o.complaint_type = "Out of Scope"
                                    o.owner = nil
                                  }
                                                                
    aasm_state :ignored,
               :enter => Proc.new { |o|
                                     o.owner = nil
                                  }
                                  
    aasm_state :addressed,
               :enter => Proc.new { |o|
                                     o.owner = nil
                                  }
    
    aasm_event :submit_for_review do
      transitions :to => :cust_svc_mgr_review, :from => :in_creation, :guard => :ready_for_cust_svc_mgr_review?
    end

    aasm_event :classify_as_out_of_scope do
      transitions :to => :out_of_scope, :from => :cust_svc_mgr_review
    end

    aasm_event :classify_as_minor do
      transitions :to => :store_mgr_review, :from => :cust_svc_mgr_review
    end

    aasm_event :classify_as_intermediate do
      transitions :to => :cust_svc_spclst_review, :from => :cust_svc_mgr_review
    end

    aasm_event :review_complete do
      transitions :to => :pending_action, :from => :cust_svc_spclst_review
    end

    aasm_event :classify_as_major do
      transitions :to => :attorney_review, :from => :cust_svc_mgr_review
    end

    aasm_event :ignore do
      transitions :to => :ignored, :from => :store_mgr_review, :guard => :tasks_complete?
    end

    aasm_event :close_out do
      transitions :to => :addressed, :from => [:store_mgr_review, :pending_action],
                  :guard => :tasks_complete?
    end
    
    aasm_event :lawyer_close_out do
      transitions :to => :addressed, :from => [:attorney_review],
                  :guard => :tasks_complete?, :on_transition => :lawyer_close_out
      
      def required_data
        {:resolution_information => :text}
      end
    end
  end
  
  named_scope :closed, :conditions => { "aasm_state", ["out_of_scope", "ignored", "addressed"]}
  named_scope :open, :conditions => ["aasm_state NOT IN (?)", ["out_of_scope", "ignored", "addressed"]]
  
  
  belongs_to :store
  # categories defined as constants for simple example
  Service="service"
  Quality="quality"
  Other="other"
  Overall="overall"

  Categories = [Complaint::Service, Complaint::Quality, Complaint::Other, Complaint::Overall]
  
  
  def tasks_complete?
    errors.clear
    errors.add("Follow Up Actions", "must be addressed before you can do that") if (follow_up_actions.active.count != 0)
    errors.empty?
  end

  def ready_for_cust_svc_mgr_review?
    errors.clear
    errors.add("Category", "cannot be blank for this transition") if category.blank?
    errors.add("Store", "must be set for this transition") if ((category != Complaint::Overall) && store.nil?)
    errors.add("Description", "cannot be blank for this transition") if description.blank?
    errors.empty?
  end
  
  def lawyer_close_out(*params)
    params.inspect
  end
  
end
