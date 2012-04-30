module WebdevToolbox
  
  mattr_accessor :root_dir, :overlays_directory
  self.root_dir = 'public'
  self.overlays_directory = 'images/overlays'

  class App
    def self.call(env)
      Dir.chdir WebdevToolbox.root_dir if Dir[WebdevToolbox.root_dir]
      images_urls = Dir[ WebdevToolbox.overlays_directory + '/*.*' ].map{|path| '/'+path}
      [200, {"Content-Type" => "text/html"}, images_urls.to_json]
    end
  end

  module Rails
    class Engine < ::Rails::Engine
    end
  end
end

