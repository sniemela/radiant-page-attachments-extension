class Admin::PageAttachmentsController < ApplicationController
  
  def index
    @attachments = PageAttachment.all(:conditions => {:parent_id => nil}, :include => [:page], :order => 'title, filename').paginate :per_page => 25, :page => params[:page]
  end
  def grid
    @attachments = PageAttachment.all(:conditions => {:parent_id => nil}, :include => [:page], :order => 'title, filename').paginate :per_page => 25, :page => params[:page]
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
  
	def move_higher
		if request.post?
			@attachment = PageAttachment.find(params[:id])
			@attachment.move_higher
			render :partial => 'admin/page/attachment', :layout => false, :collection => @attachment.page.attachments
		end
	end

	def move_lower
		if request.post?
			@attachment = PageAttachment.find(params[:id])
			@attachment.move_lower
			render :partial => 'admin/page/attachment', :layout => false, :collection => @attachment.page.attachments
		end
	end
	
	def destroy
		if request.post?
			@attachment = PageAttachment.find(params[:id])
			page = @attachment.page
			@attachment.destroy
			render :partial => 'admin/page/attachment', :layout => false, :collection => page.attachments
		end
	end
end