#= require 'lib/jquery.js'
#= require 'lib/underscore.js'
#= require 'lib/backbone.js'
#= require 'lib/keymaster.js'
#= require 'lib/html5slider.js'

#= require 'init'

#= require 'mixins/hideable'
#= require 'mixins/storable'
#= require 'views/draggable'

#= require 'views/menu'
#= require 'models/images_manager'
#= require 'views/images_container'
#= require 'views/draggable_image'
#= require 'views/image'
#= require 'views/images_directory'
#= require 'views/page_settings'
#= require 'views/images_manager'
#= require 'overlays_panel'

OverlayMe.init = ->
  return unless @mustLoad()
  @injectCSS()
  @initKeyMoves()

  $o =>
    @menu          = new @Views.MenuClass() unless @menu
    @overlay_panel = new @OverlaysPanel() unless @overlay_panel

  @setLoaded()

OverlayMe.init()
