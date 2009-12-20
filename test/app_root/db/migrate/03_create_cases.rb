class CreateCases < ActiveRecord::Migration

  def self.up
    create_table :cases do |t|
      t.string :name
      t.string :regarding
      t.string :aasm_state
      t.timestamps
    end
  end

  def self.down
    drop_table :cases
  end
  
end
