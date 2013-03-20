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
#= require 'views/images_container'
#= require 'views/draggable_image'
#= require 'views/image'
#= require 'views/images_directory'
#= require 'models/dynamic_images_mngmt'
#= require 'views/content_div_mngmt'
#= require 'views/images_mngt_div'
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
