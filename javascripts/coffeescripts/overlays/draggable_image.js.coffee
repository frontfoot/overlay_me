#= require 'draggable'

class OverlayMe.Overlays.DraggableImage extends OverlayMe.Draggable

  className: 'image'

  initialize: (attributes, options) ->
    super(attributes, options)

    @image = new Image()
    @src   = options.image_src

    $o(@image).load => # when image loaded
      @fitDivToImage()
      @setAsLastMoved()
      
    $o(@image).attr 'src', @src
    $o(@el).append @image

    # force positioning to 0 by default
    $o(@el).css('left', 0) if $o(@el).css('left') == 'auto' || $o(@el).css('left') == ''
    $o(@el).css('top', 0) if $o(@el).css('top') == 'auto' || $o(@el).css('top') == ''

    $o(@el)
      .on 'mousedown', (e) =>
        @toggleMove e
      .on 'mouseover', (e) =>
        $o(".overlay-image-block[data-img-id=#{@id}]").addClass 'hovered'
      .on 'mouseout', (e) =>
        $o(".overlay-image-block[data-img-id=#{@id}]").removeClass 'hovered'

    $o(window).bind 'mouseup', (e) =>
      @endMove e

  fitDivToImage: ->
    if @image.width > 0
      $o(@el).css 'width', @image.width
      $o(@el).css 'height', @image.height

  render: ->
    @el

