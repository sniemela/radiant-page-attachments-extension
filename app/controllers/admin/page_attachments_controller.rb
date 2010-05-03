class Admin::PageAttachmentsController < ApplicationController
  
  def index
    @attachments = PageAttachment.all(:conditions => {:parent_id => nil}, :include => [:page], :order => 'title, filename').paginate(@pagination_parameters)
  end
  def grid
    @attachments = PageAttachment.all(:conditions => {:parent_id => nil}, :include => [:page], :order => 'title, filename').paginate(@pagination_parameters)
  end
  
  def edit
    @page_attachment = PageAttachment.find(params[:id])
  end
  def update
    @page_attachment = PageAttachment.find(params[:id])
    params[:page_attachment].each do |k,v|
      @page_attachment[k] = v
    end
    if @page_attachment.save!
      redirect_to admin_page_attachments_url
    else
      render :edit
    end
  end

end