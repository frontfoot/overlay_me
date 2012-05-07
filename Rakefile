require 'rubygems'
require "bundler/setup"
require 'sprockets'
require 'sprockets-sass'
require 'compass'
require 'rake/sprocketstask'
require 'jsmin'
require 'yui/compressor'

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

desc "strip out local css loading blocks and replace it with online one"
task :change_css_local_link_to_online_server do

  online_css_url = 'http://dev.frontfoot.com.au/overlay_me/style.css'

  puts "\n** Change CSS href link to our online file [#{online_css_url}] **"

  js_file = "overlay_me/load.js"
  js_string = File.read(js_file)

  # stripping out duplicity of createTag
  js_string = js_string.gsub(/createTag\(.*createTag\(/m, 'createTag(')

  # then replacing css href with the online url
  js_string = js_string.gsub(/(createTag\(.*href: *)'[^']+'/m, "\\1 '#{online_css_url}'")

  File.open(js_file, 'w') {|f| f.write(js_string) } 
end

namespace :minify do
  desc "minify the assets"
  task :js do
    js_file = "overlay_me/load.js"
    puts "\n** Minify JS file #{js_file} **"

    js_string = File.read(js_file)
    File.open(js_file, 'w') {|f| f.write(JSMin.minify(js_string)) } 
  end

  task :css do
    css_file = "overlay_me/style.css"
    puts "\n** Minify CSS file #{css_file} **"

    css_string = File.read(css_file)
    File.open(css_file, 'w') {|f| f.write(YUI::CssCompressor.new.compress(css_string)) } 
  end

  task :all => [:js, :css]
end

desc "add a header on the minified js file to properly redirect curious"
task :prepend_header do
  js_file = "overlay_me/load.js"
  puts "\n** Prepend header to JS file **"

  js_header  = "// OverlayMe v#{OverlayMe::VERSION}\n"
  js_header += "//\n"
  js_header += "// #{File.open('LICENSE'){|f| f.readline().chomp() }}\n"
  js_header += "// OverlayMe is freely distributable under the MIT license.\n"
  js_header += "// http://github.com/frontfoot/overlay_me\n\n"

  puts js_header

  original_content = File.read(js_file)
  File.open(js_file, 'w') do |f|
    f.write(js_header)
    f.write(original_content)
  end

end

desc "push files on a public accessible server"
task :publish => [:compile, :change_css_local_link_to_online_server, 'minify:all', :prepend_header] do
  pub = YAML.load_file(File.join("config", "publishing_server.yml"))

  puts "\n** Push files to server #{pub['server']} **"

  cmd = "scp -r overlay_me #{pub['user']}@#{pub['server']}:#{pub['public_dir']}/"
  puts cmd
  system cmd
end

