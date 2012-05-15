require 'rubygems'
require "bundler/setup"
require 'sprockets'
require 'sprockets-sass'
require 'compass'
require 'rake/sprocketstask'
require 'jsmin'
require 'yui/compressor'
require 'listen'

ENV['js_sprocket'] = "overlay_me.js"
ENV['js_minified'] = "vendor/assets/javascripts/overlay_me/overlay_me.min.js"
ENV['css_sprocket'] = "overlay_me.css"
ENV['css_minified'] = "style.min.css"

ENV['addon_layout_resizer'] = "addons/layout_resizer.js"

desc "default sprockets [:assets] compiling"
Rake::SprocketsTask.new do |t|
  environment = Sprockets::Environment.new
  environment.append_path 'javascripts'
  environment.append_path 'stylesheets'
  environment.append_path 'spec/javascripts/coffeescript'

  t.environment = environment
  t.output      = "./"
  t.assets      = [ ENV['js_sprocket'], ENV['css_sprocket'], ENV['addon_layout_resizer'], ENV['addon_layout_resizer'] ]
end

desc "remove DIGEST from filenames"
task :remove_digest do
  puts "\n** Rename compiled files without generated DIGEST **"
  Dir["{.,addons}/*-*.{js,css}"].each do |file|
    new_file = file.sub /(.*)-[^\.]+(\.[^\.]+)/, '\1\2'
    puts "#{file} -> #{new_file}"
    `mv #{file} #{new_file}`
  end
end

desc "compile assets with Sprockets, remove DIGEST, move some files"
task :compile => [:assets, :remove_digest] do
  puts "\n** Move addons into vendor/asssets/ **"
  `mv addons vendor/assets/javascripts/overlay_me/`
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
    File.open(ENV['js_sprocket'], 'w') { |f| f.write(js_string) }
    `rm #{ENV['css_minified']}` # remove minified css file
  end

  task :js do
    puts "\n** Minify JS file #{ENV['js_sprocket']} -> #{ENV['js_minified']} **"
    File.open(ENV['js_minified'], 'w') do |file|
      file.write(JSMin.minify(File.read(ENV['js_sprocket'])))
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
end

desc "package, aka prepare the minified .js"
task :package => [:compile, 'minify:all_in_one']

desc "Watch javascripts and stylesheets folders re-package the assets at each change"
task :watch do
  callback = Proc.new do
    `rake package`  # trust me I'm not proud... but couldn't find any better
    puts 'done'
  end
  listener = Listen.to('stylesheets', 'javascripts')
  listener.latency(0.5)
  listener.change(&callback)
  listener.start
end

