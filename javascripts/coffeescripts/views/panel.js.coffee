class OverlayMe.Views.Panel extends Backbone.View

  render: ->
    $content = $o(@el)
    _.each @content, (el) ->
      $content.append $o(el)

    @el

  initialize: (attributes, options) ->
    @$el = $o(@el)
    @$el.addClass 'overlays-panel'

    # adding image management block
    OverlayMe.imagesManagerView = new OverlayMe.Views.ImagesManager()

    # add #container management & image management blocks
    @content = [
      new OverlayMe.Views.PageSettings().render(),
      OverlayMe.imagesManagerView.render()
    ]

    # add the panel to the page menu
    OverlayMe.menu.append @render()

    # repeating original window#mousemove event
    # to be able to unbind it without interfering with window event
    $o(window).bind 'mousemove', (event) ->
      $o(window).trigger('om-mousemove', event)

    # once everything rendered, load dynamicly added images
    OverlayMe.imageManager = new OverlayMe.Models.ImagesManager()
    OverlayMe.imageManager.loadAll()

    OverlayMe.loadDefaultImage = ->
      # double check that the dynamic loading list is also empty
      if OverlayMe.imageManager.isEmpty()
        OverlayMe.imageManager.add('http://octodex.github.com/images/original.jpg', {css: { left: "#{window.document.width*.6}px"}} )

    OverlayMe.loadDefaultImage()
