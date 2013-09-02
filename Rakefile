require 'rubygems'
require "bundler/setup"
require 'sprockets'
require 'sprockets-sass'
require 'compass'
require 'jsmin'
require 'yui/compressor'

namespace :assets do

  # ensure lib directory is present
  Dir.mkdir("lib") unless Dir.exists?("lib")

  ENV['js_sprocket'] = "lib/overlay_me.js"
  ENV['js_with_css'] = "lib/overlay_me.css_embedded.js"
  ENV['js_minified'] = "lib/overlay_me.min.js"
  ENV['css_sprocket'] = "lib/overlay_me.css"
  ENV['css_minified'] = "lib/overlay_me.min.css"

  # config to remove the original filenames into generated css (bloody useful for dev though)
  Sprockets::Sass.options[:line_comments] = false

  desc "sprockets compiling/jamming"
  task :compile do
    puts "\n** Sprocketting #{ENV['js_sprocket']}, #{ENV['css_sprocket']}, #{ENV['addon_layout_resizer']} **"
    
    environment = Sprockets::Environment.new
    environment.append_path 'src'
    environment.append_path 'src/stylesheets'

    File.open(ENV['js_sprocket'], 'w'){ |f| f.write(environment[File.basename(f.path)].to_s) }
    File.open(ENV['css_sprocket'], 'w'){ |f| f.write(environment[File.basename(f.path)].to_s) }
  end

  desc "minify the assets"
  namespace :minify do

    task :css do
      puts "\n** Minify CSS file #{ENV['css_sprocket']} -> #{ENV['css_minified']} **"
      File.open(ENV['css_minified'], 'w') do |file|
        file.write(YUI::CssCompressor.new.compress(File.read(ENV['css_sprocket'])))
      end
    end

    task :add_minified_css_to_js do
      puts "\n** Add CSS minified blob inline in the javascript :! **"

      css_blob = File.read(ENV['css_minified'])
      js_string = File.read(ENV['js_sprocket']).gsub(/#CSS_BLOB#/, css_blob)
      File.open(ENV['js_with_css'], 'w') { |f| f.write(js_string) }
      `rm #{ENV['css_minified']}` # remove minified css file
    end

    task :js do
      puts "\n** Minify JS file #{ENV['js_with_css']} -> #{ENV['js_minified']} **"
      File.open(ENV['js_minified'], 'w') do |file|
        file.write(JSMin.minify(File.read(ENV['js_with_css'])))
      end
    end

    desc "add a header on the minified js file to properly redirect curious"
    task :prepend_header do
      puts "\n** Prepend header to compiled files **"

      header  = "// OverlayMe v#{OverlayMe::VERSION}\n"
      header += "// http://github.com/frontfoot/overlay_me\n"
      header += "//\n"
      header += "// #{File.open('LICENSE'){|f| f.readline().chomp() }}\n"
      header += "// OverlayMe is freely distributable under the MIT license.\n"
      header += "//\n"
      header += "// Includes:\n"
      header += "// - jQuery - http://jquery.com/ - Copyright 2011, John Resig\n"
      header += "// - Backbone.js - http://documentcloud.github.com/backbone - (c) 2010 Jeremy Ashkenas, DocumentCloud Inc.\n"
      header += "// - Underscore.js - http://documentcloud.github.com/underscore - (c) 2011 Jeremy Ashkenas, DocumentCloud Inc.\n"
      header += "// - keymaster - http://github.com/madrobby/keymaster - Copyright (c) 2011-2012 Thomas Fuchs\n"
      header += "// - html5slider - https://github.com/fryn/html5slider - Copyright (c) 2010-2011 Frank Yan\n"
      header += "\n"
      puts header

      original_content = File.read(ENV['js_minified'])
      File.open(ENV['js_minified'], 'w') do |f|
        f.write(header)
        f.write(original_content)
      end
    end

    task :all_in_one => [:css, :add_minified_css_to_js, :js, :prepend_header]
    task :only_css_for_js_debug => [:css, :add_minified_css_to_js]
  end

  desc "package, aka prepare the minified .js"
  task :package => [:compile, 'minify:all_in_one']

  desc "compile all js in 1, but no minifying (useful for jasmine tests via guard; use 'rake guard')"
  task :compile_debug => [:compile, 'minify:only_css_for_js_debug']

end

