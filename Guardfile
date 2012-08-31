# A Guardfile
# More info at https://github.com/guard/guard#readme

require 'coffee_script'

guard 'sprockets', :destination => "javascripts", :root_file => "overlay_me.js" do
  watch (%r{javascripts/coffeescripts/*})
end

guard 'rake', :task => 'assets:compile_debug' do
  watch(%r{^javascripts/overlay_me.js})
  watch(%r{^stylesheets/scss/overlay_me.css.scss})
end

guard 'coffeescript', :input => 'spec/javascripts/coffeescripts', :output => 'spec/javascripts', :all_on_start => true

