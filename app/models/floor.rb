class Floor < ActiveRecord::Base
  belongs_to :user
  has_many :groups
  
  attr_protected :user_id
  
  def group_ids
    YAML::load(@attributes['group_ids']) unless @attributes['group_ids'].blank?
  end
  
  def group_ids=(ids)
    if ids.is_a?(Array)
      group_postion_at = 0;
      ids.each do |gid|
        group = Group.find(gid)
        if group.user_id == self.user_id
          group.postion_at = group_postion_at
          self.groups << group
          group_postion_at = group_postion_at + 1
        end
      end
    end
    @attributes['group_ids'] = ids
  end
end
