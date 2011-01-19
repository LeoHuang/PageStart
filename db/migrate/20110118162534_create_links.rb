class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :name
      t.integer :postion_at
      t.string :url
      t.string :favicon_img
      t.integer :rank
      t.integer :hit_count
      t.string :status

      t.timestamps
    end
    add_index :links, :user_id 
    add_index :links, :group_id
  end

  def self.down
    drop_table :links
  end
end
