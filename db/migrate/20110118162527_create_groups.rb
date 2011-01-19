class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :user_id
      t.integer :floor_id
      t.integer :kind,    :default => 0  
      t.string :name
      t.integer :postion_at
      t.string :status

      t.timestamps
    end
    add_index :groups, :user_id 
    add_index :groups, :floor_id 
    
  end

  def self.down
    drop_table :groups
  end
end
