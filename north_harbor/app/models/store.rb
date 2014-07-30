class Store < ActiveRecord::Base
  has_many :complaints
  belongs_to :manager, :class_name => "User"
  belongs_to :store
  
  def name
    location
  end
  
end
