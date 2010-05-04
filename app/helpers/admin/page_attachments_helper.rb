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
    sample_start = h(%{<r:attachment name='#{attachment.filename}'#{url_scope}>})
    sample_middle = h(%{<r:link title='#{escape_javascript(attachment.title)}' />})
    sample_end = h(%{</r:attachment>})
    
    if attachment.filename.match(/\.(jpg|gif|png|jpeg|tiff?)$/)
      sample_middle = h(%{<r:image alt='#{escape_javascript(attachment.title)}'/>})
    end
    
    code = sample_start + sample_middle + sample_end
    tag("input", {:type => 'text', :value => code, :size => 60})
  end
end