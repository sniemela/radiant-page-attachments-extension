namespace :radiant do
  namespace :extensions do
    namespace :page_attachments do

      desc "Runs the migration of the Page Attachments extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          PageAttachmentsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          PageAttachmentsExtension.migrator.migrate
        end
      end

      desc "Copies public assets of the Page Attachments to the instance public/ directory."
      task :update => :environment do
        puts "Copying assets from PageAttachmentsExtension"
        FileUtils.cp PageAttachmentsExtension.root + "/public/stylesheets/admin/page_attachments.css", RAILS_ROOT + "/public/stylesheets/admin"
        FileUtils.cp PageAttachmentsExtension.root + "/public/javascripts/admin/page_attachments.js", RAILS_ROOT + "/public/javascripts/admin"
        FileUtils.mkdir RAILS_ROOT + "/public/images/admin/page_attachments" unless File.exist? "#{RAILS_ROOT}/public/images/admin/page_attachments"
        FileUtils.cp PageAttachmentsExtension.root + "/public/images/admin/drag_order.png", RAILS_ROOT + "/public/images/admin/page_attachments"
      end
    end
  end
end
