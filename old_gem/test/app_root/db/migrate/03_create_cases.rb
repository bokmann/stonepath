class CreateCases < ActiveRecord::Migration

  def self.up
    create_table :cases do |t|
      t.string :name
      t.string :regarding
      t.string :description
      t.string :aasm_state
      t.string :notification_method
      t.integer :notified_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cases
  end
  
end
