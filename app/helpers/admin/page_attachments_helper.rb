module Admin::PageAttachmentsHelper
  def preview_path(attachment)
    case attachment.filename
    when /pdf$/
      attachment_path = '/images/admin/page_attachments/pdf_icon.png'
    else
      attachment_path = attachment.public_filename
    end
    attachment_path
  end
  
  def sample_attachment_code(attachment, page = nil)
    url_scope = ''
    unless @page
      url_scope = " url='#{attachment.page.url}'"
    end
    if attachment.filename.match(/\.(jpg|gif|png|jpeg|tiff?)$/)
      code = h(%{<r:attachment name='#{attachment.filename}'#{url_scope}><r:image/></r:attachment>})
    else
      code = h(%{<r:attachment name='#{attachment.filename}'#{url_scope}><r:link/></r:attachment>})
    end        
    tag("input", {:value => "#{code}", :type => 'text', :value => code, :size => 60})
  end
end