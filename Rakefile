require 'rubygems'
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
  tmp_string = ""

  File.open(js_file, "r+") do |f|
    while(!f.eof?)
      tmp_string += f.readline
    end
  end

  # stripping out duplicity of createTag
  tmp_string = tmp_string.gsub(/createTag\(.*createTag\(/m, 'createTag(')

  # then replacing css href with the online url
  tmp_string = tmp_string.gsub(/(createTag\(.*href: *)'[^']+'/m, "\\1 '#{online_css_url}'")

  File.open(js_file, 'w') {|f| f.write(tmp_string) } 
end

desc "minify the assets"
task :minify_js do
  js_file = "overlay_me/load.js"
  puts "\n** Minify JS file #{js_file} **"
  tmp_string = ""

  File.open(js_file, "r+") do |f|
    while(!f.eof?)
      tmp_string += f.readline
    end
  end

  File.open(js_file, 'w') {|f| f.write(JSMin.minify(tmp_string)) } 
end
task :minify_css do
  css_file = "overlay_me/style.css"
  puts "\n** Minify CSS file #{css_file} **"
  tmp_string = ""

  File.open(css_file, "r+") do |f|
    while(!f.eof?)
      tmp_string += f.readline
    end
  end

  File.open(css_file, 'w') {|f| f.write(YUI::CssCompressor.new.compress(tmp_string)) } 
end
task :minify => [:minify_js, :minify_css]

desc "push files on a public accessible server"
task :publish => [:compile, :change_css_local_link_to_online_server, :minify] do
  pub = YAML.load_file(File.join("config", "publishing_server.yml"))

  puts "\n** Push files to server #{pub['server']} **"

  cmd = "scp -r overlay_me #{pub['user']}@#{pub['server']}:#{pub['public_dir']}/"
  puts cmd
  system cmd
end

