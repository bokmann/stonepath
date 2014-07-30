class CreateAssignments < ActiveRecord::Migration

  def self.up
    create_table :assignments do |t|
      t.string :aasm_state
      t.integer :workitem_id
      t.string :workitem_type
      t.integer :workbench_id
      t.string :workbench_type
      t.datetime :completed_at
      t.datetime :due_at
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
  
end
