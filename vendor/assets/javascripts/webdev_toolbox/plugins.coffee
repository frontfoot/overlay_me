#= require 'webdev_toolbox/basics'
#= require 'webdev_toolbox/overlays'
#= require 'webdev_toolbox/layout_resizer'

createTag = (tagName, attributes) ->
  tag = document.createElement(tagName)
  tag.setAttribute(attributeName, attributes[attributeName]) for attributeName of attributes
  tag

head = document.getElementsByTagName('head')[0]
head.appendChild(createTag('link', {type:'text/css', href:'/assets/webdev_toolbox/style.css', media:'only screen', rel:'stylesheet'}));
