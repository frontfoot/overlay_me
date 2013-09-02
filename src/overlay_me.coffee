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

OverlayMe.init = ->
  return if OverlayMe.isLoaded or OverlayMe.isMobile()
  @injectCSS()
  @initKeyMoves()

   # repeating original window#mousemove event
  # to be able to unbind it without interfering with window event
  $o(window).bind 'mousemove', (event) ->
    $o(window).trigger('om-mousemove', event)

  $o =>
    @panel  = new @Views.Panel() unless @panel
    # @panel = new @Views.Panel() unless @panel
    # once everything rendered, load dynamicly added images
    OverlayMe.imageManager = new OverlayMe.Models.ImagesManager()
    OverlayMe.imageManager.loadAll()
    OverlayMe.loadDefaultImage()

  @isLoaded = true

OverlayMe.init()
