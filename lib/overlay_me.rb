module OverlayMe
  
  mattr_accessor :root_dir, :overlays_directory
  self.root_dir = Dir.pwd
  self.overlays_directory = 'images/overlays'

  # the App is used to list the images contained into the 'self.overlays_directory' directory
  class App
    def self.call(env)
      images_urls = []
      Dir.chdir OverlayMe.root_dir do 
        images_urls = Dir[ OverlayMe.overlays_directory + '/**/*.*' ].map{|path| '/'+path}
      end
      images_urls = images_urls.map{|path| path.sub(/images/, 'assets') } if self.rails_and_assets_pipeline_enabled?
      [200, {"Content-Type" => "text/html"}, images_urls.to_json]
    end

    def self.rails_and_assets_pipeline_enabled?
      if defined? ::Rails
        rails_config = ::Rails.application.config
        return rails_config.respond_to?(:assets) && rails_config.assets.try(:enabled)
      else
        return false
      end
    end

  end

  # this module is defined to make Rails handle our assets
  module Rails
    if defined? ::Rails
      class Engine < ::Rails::Engine
      end
    end
  end

end


