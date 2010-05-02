class AddIndices < ActiveRecord::Migration
  def self.up
    add_index :page_attachments, :parent_id
    add_index :page_attachments, [:page_id, :position]
  end

  def self.down
    remove_index :page_attachments, :column => [:page_id, :position]
    remove_index :page_attachments, :parent_id
  end
end
