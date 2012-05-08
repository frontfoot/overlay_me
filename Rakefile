require 'rubygems'
require "bundler/setup"
require 'sprockets'
require 'sprockets-sass'
require 'compass'
require 'rake/sprocketstask'
require 'jsmin'
require 'yui/compressor'

ENV['js_file'] = "overlay_me/load.js"
ENV['js_minified'] = "overlay_me/overlay_me.min.js"
ENV['css_file'] = "overlay_me/style.css"
ENV['css_minified'] = "overlay_me/style.min.css"

desc "default sprockets [:assets] compiling"
Rake::SprocketsTask.new do |t|
  environment = Sprockets::Environment.new
  environment.append_path 'vendor/assets/javascripts'
  environment.append_path 'vendor/assets/stylesheets'

  t.environment = environment
  t.output      = "./"
  t.assets      = %w( overlay_me/load.js overlay_me/style.css )
end

desc "compile coffeescript/sass files using Sprockets and remove DIGEST"
task :compile => [:assets] do
  puts "\n** Rename compiled files without generated DIGEST **"
  Dir["overlay_me/*-*"].each do |file|
    new_file = file.sub /(.*)-[^\.]+(\.[^\.]+)/, '\1\2'
    puts "#{file} -> #{new_file}"
    `mv #{file} #{new_file}`
  end
end

desc "minify the assets"
namespace :minify do

  task :css do
    puts "\n** Minify CSS file #{ENV['css_file']} -> #{ENV['css_minified']} **"
    File.open(ENV['css_minified'], 'w') {|f| f.write(YUI::CssCompressor.new.compress(File.read(ENV['css_file']))) }
    `rm #{ENV['css_file']}` # remove original
  end

  task :add_minified_css_to_js do
    puts "\n** Add CSS minified blob inline in the javascript :! **"

    js_string = File.read(ENV['js_file'])
    css_append = 'style = $(\'<style type="text/css" rel="stylesheet"></style>\');
                  style.html(\''+File.read(ENV['css_minified'])+'\');
                  $("head").append(style);'

    # stripping out the createTag block for the CSS blob
    js_string = js_string.gsub(/var createTag.*createTag\([^\(]*\)\);/m, css_append)

    File.open(ENV['js_file'], 'w') {|f| f.write(js_string) }
    `rm #{ENV['css_minified']}` # remove blob
  end

  task :js do
    puts "\n** Minify JS file #{ENV['js_file']} -> #{ENV['js_minified']} **"
    File.open(ENV['js_minified'], 'w') {|f| f.write(JSMin.minify(File.read(ENV['js_file']))) }
    `rm #{ENV['js_file']}` # remove original
  end

  desc "add a header on the minified js file to properly redirect curious"
  task :prepend_header do
    puts "\n** Prepend header to compiled files **"

    header  = "// OverlayMe v#{OverlayMe::VERSION}\n"
    header += "//\n"
    header += "// #{File.open('LICENSE'){|f| f.readline().chomp() }}\n"
    header += "// OverlayMe is freely distributable under the MIT license.\n"
    header += "// http://github.com/frontfoot/overlay_me\n\n"
    puts header

    original_content = File.read(ENV['js_minified'])
    File.open(ENV['js_minified'], 'w') do |f|
      f.write(header)
      f.write(original_content)
    end
  end

  task :all_in_one => [:css, :add_minified_css_to_js, :js, :prepend_header]
end

desc "push files on a public accessible server"
task :publish => [:compile, 'minify:all_in_one'] do
  pub = YAML.load_file(File.join("config", "publishing_server.yml"))

  puts "\n** Push files to server #{pub['server']} **"

  cmd = "scp -r overlay_me #{pub['user']}@#{pub['server']}:#{pub['public_dir']}/"
  puts cmd
  system cmd
end

