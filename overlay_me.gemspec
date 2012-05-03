# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name        = "overlay_me"
  s.version     = 0.91
  s.date        = '2012-05-03'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rufus Post", "Joseph Boiteau"]
  s.email       = ["joseph.b@frontfoot.com.au"]
  s.homepage    = "http://github.com/frontfoot/overlay_me"
  s.summary     = "A handy toolbox for your web development"
  s.description = "loaded dynamically over any web page, this will help you to overlay designer's work on your DOM rendering"

  ['rack', 'json', 'haml', 'coffee-script', 'sprockets-sass'].each do |dep|
    s.add_dependency(dep)
  end

  s.files         = `git ls-files | grep -v 'jpg$'`.split("\n")
  s.require_paths = ["lib"]  
end


