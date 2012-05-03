module OverlayMe
  
  mattr_accessor :root_dir, :overlays_directory
  self.root_dir = ''
  self.overlays_directory = 'images/overlays'

  class App
    def self.call(env)
      Dir.chdir OverlayMe.root_dir if Dir[OverlayMe.root_dir]
      images_urls = Dir[ OverlayMe.overlays_directory + '/*.*' ].map{|path| '/'+path}
      [200, {"Content-Type" => "text/html"}, images_urls.to_json]
    end
  end

  module Rails
    if defined? ::Rails
      class Engine < ::Rails::Engine
      end
    end
  end
end

