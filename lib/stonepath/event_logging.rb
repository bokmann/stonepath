module StonePath
  module EventLogging
    
    def log_events
      has_many :logged_events, :as => :auditable, :class_name => "EventRecord"

      define_method :aasm_event_fired do |event_name, old_state_name, new_state_name|
        current_user_id = current_user && current_user.id
        self.logged_events.create(:event_name => event_name.to_s,
                                  :old_state_name => old_state_name.to_s,
                                  :new_state_name => new_state_name.to_s,
                                  :user_id => current_user_id)
      end
    end
  end
end