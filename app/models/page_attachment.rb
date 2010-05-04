class PageAttachment < ActiveRecord::Base
  acts_as_list :scope => :page_id
  has_attachment :storage => (File.exist?(Rails.root + 'config/amazon_s3.yml') ? :s3 : :file_system),
                 :thumbnails => defined?(PAGE_ATTACHMENT_SIZES) && PAGE_ATTACHMENT_SIZES || {:icon => '50x50>'},
                 :max_size => defined?(PAGE_ATTACHMENT_MAX_FILESIZE) ? PAGE_ATTACHMENT_MAX_FILESIZE : 10.megabytes
  validates_as_attachment

  belongs_to :created_by,
             :class_name => 'User',
             :foreign_key => 'created_by'
  belongs_to :updated_by,
             :class_name => 'User',
             :foreign_key => 'updated_by'
  belongs_to :page

  def short_filename(wanted_length = 15, suffix = ' ...')
    (self.filename.length > wanted_length) ? (self.filename[0,(wanted_length - suffix.length)] + suffix) : self.filename
  end

  def short_title(wanted_length = 15, suffix = ' ...')
    return '' if self.title.blank?
    (self.title.length > wanted_length) ? (self.title[0,(wanted_length - suffix.length)] + suffix) : self.title
  end

  def short_description(wanted_length = 15, suffix = ' ...')
    return '' if self.description.blank?
    (self.description.length > wanted_length) ? (self.description[0,(wanted_length - suffix.length)] + suffix) : self.description
  end

end
