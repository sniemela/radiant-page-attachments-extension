module PageAttachmentsInterface
  def self.included(base)
    base.class_eval {
      before_filter :add_page_attachment_partials,
                    :only => [:edit, :new]
      include InstanceMethods
    }
  end

  module InstanceMethods
    def add_page_attachment_partials
      @buttons_partials ||= []
      @buttons_partials << "attachments_box"
    end
  end
end
