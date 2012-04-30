#= require 'webdev_toolbox/basics'
#= require 'webdev_toolbox/overlays'

createTag = (tagName, attributes) ->
  tag = document.createElement(tagName)
  tag.setAttribute(attributeName, attributes[attributeName]) for attributeName of attributes
  tag

head = document.getElementsByTagName('head')[0]
head.appendChild(createTag('link', {type:'text/css', href:'/stylesheets/webdev_toolbox/style.css', media:'only screen', rel:'stylesheet'}));
