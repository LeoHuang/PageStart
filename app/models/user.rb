class User < ActiveRecord::Base
  has_many :floors, :dependent=>:delete_all
  has_many :groups, :dependent=>:delete_all
  has_many :links, :dependent=>:delete_all
    
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  after_create :data_clone
    
  def data_clone
    master=User.find_by_email('i@histart.me')
    return unless master

    master.floors.each do |floor|
      f = Floor.new(floor.attributes)
      f.user = self
      self.floors << f
      f.save
      floor.groups.each do |group|
        g = Group.new(group.attributes)
        g.user = self
        f.groups << g
        g.save
        group.links.each do |link|
          l = Link.new(link.attributes)
          l.user = self
          l.hit_count = 0
          g.links << l
          l.save
        end
      end
    end
  end
    
end
