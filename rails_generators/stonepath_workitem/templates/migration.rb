class Create<%= plural_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= plural_name %> do |t|
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
    drop_table :<%= plural_name %>
  end
end
