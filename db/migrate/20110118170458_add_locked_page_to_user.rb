class AddLockedPageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :locked_page, :boolean, :default => false
  end

  def self.down
    remove_column :users, :locked_page
  end
end
