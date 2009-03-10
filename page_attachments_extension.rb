require_dependency 'application'
# require File.dirname(__FILE__) + '/lib/geometry'
# require 'tempfile'

class PageAttachmentsExtension < Radiant::Extension
  version "0.3"
  description "Adds page-attachment-style asset management."
  url "http://radiantcms.org"

   define_routes do |map|
     map.connect 'page_attachments/:action/:id', :controller => 'page_attachments'
   end
  
  def activate
    # Regular page attachments stuff
    Page.class_eval {
      include PageAttachmentAssociations
      include PageAttachmentTags
    }
    UserActionObserver.send :include, ObservePageAttachments
    
    # Support radiant 0.6.9 or newer
    if defined? Admin::PagesController
      Admin::PagesController.send :include, PageAttachmentsInterface
    else
      Admin::PageController.send :include, PageAttachmentsInterface
    end
  end

  def deactivate
  end

end
