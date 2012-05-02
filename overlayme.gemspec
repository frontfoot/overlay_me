# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name        = "overlayme"
  s.version     = 0.9
  s.date        = '2012-04-27'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rufus Post", "Joseph Boiteau"]
  s.email       = ["joseph.b@frontfoot.com.au"]
  s.homepage    = "http://github.com/frontfoot/overlayme"
  s.summary     = "A handy toolbox for your web development"
  s.description = "loaded dynamically over any web page, this will help you to overlay designer's work on your DOM rendering"

  s.add_dependency('rack') 
  s.add_dependency('json') 

  s.files        = Dir.glob("vendor/assets/{images,javascripts,stylesheets}/**/*") + %w(README.md LICENSE)
end


