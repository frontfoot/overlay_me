#= require 'init'
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
