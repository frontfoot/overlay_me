# A Guardfile
# More info at https://github.com/guard/guard#readme

#guard 'coffeescript', :input => 'spec/javascripts/coffeescripts', :output => 'spec/javascripts'
guard 'coffeescript', :input => 'javascripts/coffeescripts', :output => 'javascripts'

# guard 'rake', :task => 'assets:compile_debug' do
#   watch(%r{^javascripts/.*.coffee})
# end

guard 'sprockets', :destination => "./", :asset_paths => ['javascripts'] do
  watch (%r{^javascripts/overlay_me.js})
end
