module Technoweenie
  module AttachmentFu
    module InstanceMethods
      # Record size from file data - using the temp file is apparently unreliable
      # see http://railsforum.com/viewtopic.php?id=6307
      
      def uploaded_data=(file_data)
        if file_data.respond_to?(:content_type)
          return nil if file_data.size == 0
          self.content_type = file_data.content_type
          self.filename     = file_data.original_filename if respond_to?(:filename)
        else
          return nil if file_data.blank? || file_data['size'] == 0
          self.size = file_data['size']
          self.content_type = file_data['content_type']
          self.filename =  file_data['filename']
          file_data = file_data['tempfile']
        end
        if file_data.is_a?(StringIO)
          file_data.rewind
          set_temp_data file_data.read
        else
          self.temp_paths.unshift file_data
        end
      end
      
      def set_size_from_temp_path
          self.size = File.size(temp_path) if save_attachment? && (self.size == 0 || self.size.nil?)
      end
    end
  end
end