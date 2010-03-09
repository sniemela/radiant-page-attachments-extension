require_dependency 'application_controller'

class PageAttachmentsExtension < Radiant::Extension
  version "1.0"
  description "Adds page-attachment-style asset management."
  url "http://radiantcms.org"

   define_routes do |map|
     map.connect 'page_attachments/:action/:id', :controller => 'page_attachments'
   end

  def activate
    if self.respond_to?(:tab)
      tab "Content" do
        add_item 'Attachments', "/admin/page_attachments"
      end
    else
      admin.tabs.add 'Attachments', '/admin/page_attachments', :after => "Layouts", :visibility => [:admin]
    end
    # Regular page attachments stuff
    Page.class_eval {
      include PageAttachmentAssociations
      include PageAttachmentTags
    }
    UserActionObserver.instance.send :add_observer!, PageAttachment
    Admin::PagesController.class_eval {
      # include PageAttachmentsInterface
      helper Admin::PageAttachmentsHelper
    }
    admin.page.edit.add :form_bottom, 'attachments_box', :before => 'edit_buttons'
  end

  def deactivate
  end

end
