#= require 'lib/jquery.js'
#= require 'lib/underscore.js'
#= require 'lib/backbone.js'
#= require 'lib/keymaster.js'
#= require 'lib/html5slider.js'

# to build the 1 file minified version, we insert the minified CSS directly there
# dirty but so convenient!
$o('head').append('<style rel="stylesheet" type="text/css">#CSS_BLOB#</style>')

# initialize Models/Views namespaces
window.OverlayMe = {}
window.OverlayMe.Mixin = {}

# add a flag to stop crazy bookmarklet clicking
OverlayMe.isLoaded = ->
  window.overlay_me_loaded

OverlayMe.setLoaded = ->
  window.overlay_me_loaded = true

# check if browser is a mobile device
OverlayMe.isMobile = ->
  OverlayMe.userAgent().match /(iPhone|iPod|iPad|Android)/

# give a shortName method for checks in the app
OverlayMe.mustLoad = ->
  !OverlayMe.isLoaded() && !OverlayMe.isMobile()

# helper to clear all stored informations and reload the page
OverlayMe.clearAndReload = ->
  localStorage.clear()
  OverlayMe.pageReload()

OverlayMe.toggle = ->
  $o(window).trigger 'overlay_me:toggle_all_display'
  $o(window).trigger 'overlay_me:toggle_overlay_me_images_container_display'

# separate system calls in a local functions (allow tests stubing)
OverlayMe.pageReload = ->
  window.location.reload()
OverlayMe.userAgent = ->
  navigator.userAgent

# move last image touched by keypress
OverlayMe.moveLast = (dirs, multiplier = 1) ->
  lastMovedId = localStorage.getItem 'last-moved'
  image = $o("##{lastMovedId}")
  image.css 
    left: image.position().left + dirs[0] * multiplier
    top:  image.position().top  + dirs[1] * multiplier
  .trigger 'save'

moves =
  'left':  [-1, 0], 
  'right': [1, 0], 
  'down':  [0, 1], 
  'up':    [0, -1] 

$o.each moves, (keyPressed, dirs) ->
  key keyPressed, ->
    OverlayMe.moveLast dirs
    false
  key "shift+#{keyPressed}", ->
    OverlayMe.moveLast dirs, 15
    false
