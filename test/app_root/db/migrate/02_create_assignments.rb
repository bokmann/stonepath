class CreateAssignments < ActiveRecord::Migration

  def self.up
    create_table :assignments do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
  
end
