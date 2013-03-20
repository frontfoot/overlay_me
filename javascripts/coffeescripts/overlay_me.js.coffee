#= require 'lib/jquery.js'
#= require 'lib/underscore.js'
#= require 'lib/backbone.js'
#= require 'lib/keymaster.js'
#= require 'lib/html5slider.js'

#= require 'init'

#= require 'mixins/hideable'
#= require 'mixins/storable'
#= require 'draggable'

#= require 'menu'
#= require 'overlays/init'
#= require 'overlays/images_container'
#= require 'overlays/draggable_image'
#= require 'overlays/image'
#= require 'overlays/images_directory'
#= require 'overlays/dynamic_images_mngmt'
#= require 'overlays/content_div_mngmt'
#= require 'overlays/images_mngt_div'
#= require 'overlays_panel'

OverlayMe.init = ->
  return unless @mustLoad()
  @injectCSS()
  @initKeyMoves()

  $o =>
    @menu          = new @MenuClass() unless @menu
    @overlay_panel = new @OverlaysPanel() unless @overlay_panel

  @setLoaded()

OverlayMe.init()
