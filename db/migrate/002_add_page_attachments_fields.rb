class AddPageAttachmentsFields < ActiveRecord::Migration
  def self.up
    add_column :page_attachments, :title,       :string
    add_column :page_attachments, :description, :string
    add_column :page_attachments, :position,    :integer
    
    PageAttachment.all(:select => 'page_id',
      :conditions => 'page_id IS NOT NULL AND position IS NULL',
      :group => 'page_id'
    ).each do |pending|
      PageAttachment.find_all_by_page_id(pending.page_id, :order => :id).each_with_index do |pa, i|
        pa.update_attribute :position, i + 1
      end
    end
  end

  def self.down
    remove_column :page_attachments, :position
    remove_column :page_attachments, :description
    remove_column :page_attachments, :title
  end
end
