module StonePath
  module EventLogging
    
    def log_events
      has_many :logged_events, :as => :auditable, :class_name => "EventRecord", :order => "created_at"

      define_method :aasm_event_fired do |event_name, old_state_name, new_state_name|
        self.logged_events.create(:event_name => event_name.to_s,
                                  :old_state_name => old_state_name.to_s,
                                  :new_state_name => new_state_name.to_s,
                                  :user => User.current)
      end
    end
  end
end