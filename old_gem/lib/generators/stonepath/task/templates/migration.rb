class Create<%= file_name.tableize.classify.pluralize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= file_name.tableize %> do |t|
      
      # don't change these unless you want to get deep into meta in the
      # stonepath gem.
      t.string :aasm_state
      t.references :workitem, :polymorphic => true
      t.references :workbench, :polymorphic => true
      
      t.datetime :due_at
      t.datetime :completed_at
      t.timestamps
      
      # This "urgent at' concept was useful in one of the domains StonePath
      # was written/extracted from.  The idea is that while something is 'due'
      # at a specific time, it might become urgent shortly before it is due.
      # In that domain, we color-coded tasks as green (due date is far out)
      # yellow (urgent timestap has passed), and red (overdue - due date  
      # has passed).  This won't become part of the framework, but I like the
      # idea so much I thought I'd comment it here until it gets in some
      # official documentation for 'advanced usage'.
      # t.datetime :urgent_at
      
      # Your attributes should be defined here.
    <%- for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <%- end -%>

    end
  end

  def self.down    
    drop_table :<%= file_name.tableize %>
  end
end