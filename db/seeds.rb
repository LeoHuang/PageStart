# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user = User.create(:name=>'Start Page', :email=>'leo@eidcenter.com', :password => 'leo@eidcenter')

0.upto(2) do |i|
  floor = Floor.new(:name => "Floor #{i}", :postion_at=>i)
  floor.user = user
  floor.save
  if i==0
    group = Group.new(:name => "MOST VISITED", :floor_id => floor.id, :postion_at=>0, :kind => 1)
    group.user = user
    group.save
  end
  0.upto(6) do |ii|
    group = Group.new(:name => "Group Name #{ii}", :floor_id => floor.id, :postion_at=>ii)
    group.user = user
    group.save
  end
end