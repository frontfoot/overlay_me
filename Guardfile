# A Guardfile
# More info at https://github.com/guard/guard#readme

guard 'coffeescript', :input => 'spec/javascripts/coffeescripts', :output => 'spec/javascripts'

guard 'rake', :task => 'assets:compile_debug' do
  watch(%r{^javascripts/.*.coffee})
end
