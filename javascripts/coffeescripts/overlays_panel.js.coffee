class OverlayMe.OverlaysPanel extends Backbone.View

  render: ->
    $content = $o(@el)
    _.each @content, (el) ->
      $content.append $o(el)

    @el

  initialize: (attributes, options) ->
    @$el = $o(@el)
    @$el.addClass 'overlays-panel'

    # adding image management block
    OverlayMe.images_management_div = new OverlayMe.Views.ImagesManager()

    # add #container management & image management blocks
    @content = [
      new OverlayMe.Views.PageSettings().render(),
      OverlayMe.images_management_div.render()
    ]

    # add the panel to the page menu
    OverlayMe.menu.append @render()

    # repeating original window#mousemove event
    # to be able to unbind it without interfering with window event
    $o(window).bind 'mousemove', (event) ->
      $o(window).trigger('om-mousemove', event)

    # once everything rendered, load dynamicly added images
    OverlayMe.dyn_manager = new OverlayMe.Models.ImagesManager()
    OverlayMe.dyn_manager.loadAll()

    OverlayMe.loadDefaultImage = ->
      # double check that the dynamic loading list is also empty
      if OverlayMe.dyn_manager.isEmpty()
        OverlayMe.dyn_manager.addImage('http://octodex.github.com/images/original.jpg', {css: { left: "#{window.document.width*.6}px"}} )

    OverlayMe.loadDefaultImage()
