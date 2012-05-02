#= require 'webdev_toolbox/basics'
#= require 'webdev_toolbox/overlays'

createTag = (tagName, attributes) ->
  tag = document.createElement(tagName)
  tag.setAttribute(attributeName, attributes[attributeName]) for attributeName of attributes
  tag

head = document.getElementsByTagName('head')[0]

# the dirty way: couldn't find a way to force middleman sprockets conf to use /assets for all (as Rails do) 
# so loading both (and always 1 fail)
head.appendChild(createTag('link', {type:'text/css', href:'/assets/webdev_toolbox/style.css', media:'only screen', rel:'stylesheet'}))
head.appendChild(createTag('link', {type:'text/css', href:'/stylesheets/webdev_toolbox/style.css', media:'only screen', rel:'stylesheet'}))
