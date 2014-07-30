class CreateEventRecords < ActiveRecord::Migration
  def self.up
    create_table :event_records do |t|
      
      t.references :auditable, :polymorphic => true
      t.string :event_name
      t.string :old_state_name
      t.string :new_state_name
      t.integer :user_id  #This will rely on the acl controller hack
      t.timestamps
    end
  end

  def self.down    
    drop_table :event_records
  end
end