class Group < ActiveRecord::Base
  has_many :links, :dependent=>:delete_all
  belongs_to :user
  belongs_to :floor
  
  attr_protected :user_id
  
  def floor_name=(name)
   
  end
  
  def floor_name
    self.floor.name if self.floor
  end
end
