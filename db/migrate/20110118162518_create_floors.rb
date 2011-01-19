class CreateFloors < ActiveRecord::Migration
  def self.up
    create_table :floors do |t|
      t.integer :user_id
      t.string :name
      t.integer :postion_at
      t.string :status
      t.string :group_ids

      t.timestamps
    end
    add_index :floors, :user_id 
  end

  def self.down
    drop_table :floors
  end
end
