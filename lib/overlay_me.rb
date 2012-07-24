module OverlayMe
  
  mattr_accessor :root_dir, :overlays_directory
  self.root_dir = ''
  self.overlays_directory = 'images/overlays'

  class App
    def self.call(env)
      Dir.chdir OverlayMe.root_dir if Dir[OverlayMe.root_dir]
      images_urls = Dir[ OverlayMe.overlays_directory + '/**/*.*' ].map{|path| '/'+path}
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

end

