# A Guardfile
# More info at https://github.com/guard/guard#readme

require 'coffee_script'
require 'sass'

guard 'rake', :task => 'assets:compile_debug', :run_on_start => false do
  watch(%r{^javascripts/coffeescripts/*})
  watch(%r{^stylesheets/sass/overlay_me.css.sass})
end

guard 'coffeescript', :input => 'spec/javascripts/coffeescripts', :output => 'spec/javascripts', :all_on_start => true

