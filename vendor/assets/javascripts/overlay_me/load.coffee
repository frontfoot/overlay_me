#= require 'overlay_me/init'
#= require 'overlay_me/basics'
#= require 'overlay_me/overlays'

createTag = (tagName, attributes) ->
  tag = document.createElement(tagName)
  tag.setAttribute(attributeName, attributes[attributeName]) for attributeName of attributes
  tag

head = document.getElementsByTagName('head')[0]

# the dirty way: couldn't find a way to force middleman sprockets conf to use /assets for all (as Rails do) 
# so loading both (and always 1 fail)
head.appendChild(createTag('link', {type:'text/css', href:'/assets/overlay_me/style.css', media:'only screen', rel:'stylesheet'}))
head.appendChild(createTag('link', {type:'text/css', href:'/stylesheets/overlay_me/style.css', media:'only screen', rel:'stylesheet'}))
