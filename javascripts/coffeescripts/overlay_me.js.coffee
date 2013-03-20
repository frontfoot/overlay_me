#= require 'lib/jquery.js'
#= require 'lib/underscore.js'
#= require 'lib/backbone.js'
#= require 'lib/keymaster.js'
#= require 'lib/html5slider.js'

#= require 'init'

#= require_tree './helpers'
#= require_tree './mixins'
#= require_tree './models'
#= require_tree './views'
#= require 'overlays_panel'

OverlayMe.init = ->
  return if OverlayMe.isLoaded or OverlayMe.isMobile()
  @injectCSS()
  @initKeyMoves()

  $o =>
    @menu          = new @Views.MenuClass() unless @menu
    @overlay_panel = new @OverlaysPanel() unless @overlay_panel

  @isLoaded = true

OverlayMe.init()
