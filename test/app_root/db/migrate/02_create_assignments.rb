class CreateAssignments < ActiveRecord::Migration

  def self.up
    create_table :assignments do |t|
      t.string :aasm_state
      t.integer :case_id
      t.datetime :completed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
  
end
