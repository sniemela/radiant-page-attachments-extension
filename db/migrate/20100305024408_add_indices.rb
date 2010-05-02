class AddIndices < ActiveRecord::Migration
  def self.up
    add_index :page_attachments, :parent_id
<<<<<<< HEAD
    add_index :page_attachments, [:page_id, :position], :unique => true
=======
    add_index :page_attachments, [:page_id, :position]
>>>>>>> b125303cc6f6370bfeef77eae67c3152ecadf907
  end

  def self.down
    remove_index :page_attachments, :column => [:page_id, :position]
    remove_index :page_attachments, :parent_id
  end
end
