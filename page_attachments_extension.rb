require_dependency 'application_controller'

class PageAttachmentsExtension < Radiant::Extension
  version "1.0"
  description "Adds page-attachment-style asset management."
  url "http://radiantcms.org"

   define_routes do |map|
     map.connect 'page_attachments/:action/:id', :controller => 'page_attachments'
   end

  def activate
    Page.class_eval do
      include PageAttachmentAssociations
      include PageAttachmentTags
    end
    UserActionObserver.observe User, Page, Layout, Snippet, PageAttachment
    admin.page.edit.add :form_bottom, 'attachments_box', :before => 'edit_buttons'
  end

  def deactivate
  end

end
