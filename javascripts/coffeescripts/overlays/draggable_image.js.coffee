#= require 'draggable'

class OverlayMe.Overlays.DraggableImage extends OverlayMe.Draggable

  initialize: (attributes, options) ->
    super(attributes, options)
    @image = new Image()
    $o(@image).load => # when image loaded
      @fitDivToImage()
    $o(@image).attr 'src', options.image_src
    $o(@el).append @image

    # force positioning to 0 by default
    $o(@el).css('left', '0px') if $o(@el).css('left') == 'auto' || $o(@el).css('left') == ''
    $o(@el).css('top', '0px') if $o(@el).css('top') == 'auto' || $o(@el).css('top') == ''

    $o(@el).bind 'mousedown', (event) =>
      @toggleMove(event)

    $o(window).bind 'mouseup', (event) =>
      @endMove(event)

    $o(@el).bind 'mouseover', (event) =>
      $o(".overlay-image-block[data-img-id=#{@id}]").addClass 'hovered'

    $o(@el).bind 'mouseout', (event) =>
      $o(".overlay-image-block[data-img-id=#{@id}]").removeClass 'hovered'

  fitDivToImage: ->
    if @image.width > 0
      $o(@el).css('width', @image.width)
      $o(@el).css('height', @image.height)

  render: ->
    @el


