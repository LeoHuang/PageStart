class AddProtectPageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :protect_page, :boolean, :default => false
  end

  def self.down
    remove_column :users, :protect_page
  end
end
