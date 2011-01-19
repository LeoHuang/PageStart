class Link < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  attr_protected :user_id
end
