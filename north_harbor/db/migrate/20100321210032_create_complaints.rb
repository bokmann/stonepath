class CreateComplaints < ActiveRecord::Migration
  def self.up
    create_table :complaints do |t|
      t.string :aasm_state
      t.integer :owner_id
      t.string :category
      t.string :complaint_type
      t.integer :store_id
      t.text :description
      t.string :customer_name

      t.timestamps
    end
  end

  def self.down
    drop_table :complaints
  end
end
