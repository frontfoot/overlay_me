# -*- encoding: utf-8 -*-

require File.expand_path('../lib/overlay_me/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "overlay_me"
  s.version     = OverlayMe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joseph Boiteau"]
  s.email       = ["joseph.b@frontfoot.com.au"]
  s.homepage    = "http://github.com/frontfoot/overlay_me"
  s.summary     = "A handy toolbox for your web development"
  s.description = "loaded dynamically over any web page, this will help you to overlay designer's work on your DOM rendering"

  ['rake', 'rack', 'json', 'haml', 'coffee-script', 'sprockets-sass', 'compass'].each do |dep|
    s.add_dependency(dep)
  end

  s.files         = `git ls-files | grep -v 'jpg$'`.split("\n")
  s.require_paths = ["lib"]  
end


