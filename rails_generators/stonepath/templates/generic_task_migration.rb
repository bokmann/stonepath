class Create<%= args[0].tableize.classify %> < ActiveRecord::Migration
  def self.up
    create_table :<%= args[0].tableize %> do |t|
      
      t.string :aasm_state
      t.references :workitem, :polymorphic => true
      t.references :workbench, :polymorphic => true
      
      t.datetime :due_at
      t.datetime :completed_at
      t.timestamps
      
      # customize your task here
    end
  end

  def self.down    
    drop_table :<%= args[0].tableize %>
  end
end