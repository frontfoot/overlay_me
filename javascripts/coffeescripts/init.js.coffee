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
OverlayMe.moveLast = (relative_move_coords, multiplier = 1) ->
  last_moved_id = localStorage.getItem "last-moved"
  image = $o("##{last_moved_id}")
  image.css 'left', image.position().left + relative_move_coords[0] * multiplier
  image.css 'top', image.position().top + relative_move_coords[1] * multiplier
  image.trigger 'save'

# bind some global keypress - thx to https://github.com/madrobby/keymaster
moves = { 'left': [-1, 0], 'right': [1, 0], 'down': [0, 1], 'up': [0, -1] }
$o.each moves, (key_string, move_comb) ->
  key key_string, ->
    OverlayMe.moveLast move_comb
    false
  key 'shift+'+key_string, ->
    OverlayMe.moveLast move_comb, 15
    false

