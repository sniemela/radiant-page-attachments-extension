class RemoveUniqueIndexOnPosition < ActiveRecord::Migration
  def self.up
    remove_index :page_attachments, :column => [:page_id, :position]    # :unique => true
    add_index :page_attachments, [:page_id, :position]
  end

  def self.down
    remove_index :page_attachments, :column => [:page_id, :position]
    add_index :page_attachments, [:page_id, :position], :unique => true
  end
end
