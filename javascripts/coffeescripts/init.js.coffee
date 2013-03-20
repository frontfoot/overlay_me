# initialize Models/Views namespaces
this.OverlayMe     = {}
OverlayMe.Models   = {}
OverlayMe.Views    = {}
OverlayMe.Mixins   = {}
OverlayMe.Overlays = {}
OverlayMe.Helpers  = {}

OverlayMe.isLoaded = false

# to build the 1 file minified version, we insert the minified CSS directly there
# dirty but so convenient!
OverlayMe.injectCSS = ->
  $o('head').append('<style rel="stylesheet" type="text/css">#CSS_BLOB#</style>')

# check if browser is a mobile device
OverlayMe.isMobile = ->
  /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)

# helper to clear all stored informations and reload the page
OverlayMe.clearAndReload = ->
  localStorage.clear()
  OverlayMe.reloadPage()

# separate system calls in a local functions (allow tests stubing)
OverlayMe.reloadPage = ->
  window.location.reload()

OverlayMe.toggle = ->
  $o(window).trigger 'overlay_me:toggle_all_display'
  $o(window).trigger 'overlay_me:toggle_overlay_me_images_container_display'

# move last image touched by keypress
OverlayMe.moveLast = (dirs, multiplier = 1) ->
  lastMovedId = localStorage.getItem 'last-moved'
  image = $o("##{lastMovedId}")
  image.css 
    left: image.position().left + dirs[0] * multiplier
    top:  image.position().top  + dirs[1] * multiplier
  .trigger 'save'

OverlayMe.initKeyMoves = ->
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
