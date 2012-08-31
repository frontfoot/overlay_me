# A Guardfile
# More info at https://github.com/guard/guard#readme

#guard 'coffeescript', :input => 'spec/javascripts/coffeescripts', :output => 'spec/javascripts', :all_on_start => true
# guard 'coffeescript', :input => 'javascripts/coffeescripts', :output => 'javascripts', :all_on_start => true

# guard 'rake', :task => 'assets:compile_debug' do
#   watch(%r{^javascripts/.*.coffee})
# end

# require 'coffee-script'
# require 'sprockets'
# require 'sprockets-sass'
# environment = Sprockets::Environment.new
# environment.append_path 'javascripts/coffeescripts'
# #environment.append_path 'stylesheets'

# guard 'sprockets2', :sprockets => environment do
#   watch (%r{^javascripts/overlay_me.js})
# end

require 'coffee_script'

guard 'sprockets', :destination => "javascripts", :root_file => "overlay_me.js" do
  watch (%r{javascripts/coffeescripts/*})
end

