#= require 'lib/jquery.js'
#= require 'lib/underscore.js'
#= require 'lib/backbone.js'
#= require 'lib/html5slider.js'

# to build the 1 file minified version, we insert the minified CSS directly there
# dirty but so convenient!
$('head').append('<style rel="stylesheet" type="text/css">#CSS_BLOB#</style>')

# initialize Models/Views namespace
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

