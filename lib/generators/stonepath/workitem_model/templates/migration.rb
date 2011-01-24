class Create<%= file_name.tableize.classify.pluralize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= file_name.tableize %> do |t|
      # These are the attributes of a workitem
      t.string :aasm_state
      t.integer :owner_id
      
      # Your attributes should be defined here.
    <%- for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <%- end -%>
    <%- unless options[:skip_timestamps] -%>
      t.timestamps
    <%- end -%>
    end
    
    #I'd like to create an index on aasm_state here.
    # you might optionally want to index owner_id
  end
  
  def self.down
    drop_table :<%= file_name.tableize %>
  end
end