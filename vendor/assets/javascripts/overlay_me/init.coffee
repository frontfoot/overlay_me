#= require 'lib/jquery.min.js'
#= require 'lib/underscore.js'
#= require 'lib/backbone.js'

window.OverlayMe = {}

# add a flag to stop crazy bookmarklet clicking
OverlayMe.isLoaded = ->
  window.overlay_me_loaded

# check if browser is a mobile device
OverlayMe.isMobile = ->
  return navigator.userAgent.match /(iPhone|iPod|iPad|Android)/

# give a shortName method for checks in the app
OverlayMe.mustLoad = ->
  return !OverlayMe.isLoaded() && !OverlayMe.isMobile()

