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

# separate system calls in a local functions (allow tests stubing)
OverlayMe.pageReload = ->
  window.location.reload()
OverlayMe.userAgent = ->
  navigator.userAgent

# move last image touched by keypress
OverlayMe.moveLast = (relative_x, relative_y) ->
  last_moved_id = localStorage.getItem "last-moved"
  image = $o("##{last_moved_id}")
  image.css 'left', image.position().left + relative_x
  image.css 'top', image.position().top + relative_y
  image.trigger 'save'

# bind some global keypress - thx to https://github.com/madrobby/keymaster
key 'left', ->
  OverlayMe.moveLast -1, 0
key 'shift+left', ->
  OverlayMe.moveLast -15, 0
key 'right', ->
  OverlayMe.moveLast 1, 0
key 'shift+right', ->
  OverlayMe.moveLast 15, 0
key 'up', ->
  OverlayMe.moveLast 0, -1
key 'shift+up', ->
  OverlayMe.moveLast 0, -15
key 'down', ->
  OverlayMe.moveLast 0, 1
key 'shift+down', ->
  OverlayMe.moveLast 0, 15

