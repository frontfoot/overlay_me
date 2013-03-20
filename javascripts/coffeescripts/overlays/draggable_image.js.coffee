class OverlayMe.Overlays.DraggableImage extends OverlayMe.Draggable

  className: 'image'

  draggable:
    callbacks:
      beforeMove: ->
        @setAsLastMoved()

  initialize: (attributes, options) ->
    super(attributes, options)

    @$el = $o(@el)

    @image = new Image()
    @src   = options.src

    $o(@image).load => # when image loaded
      @fitDivToImage()
      @setAsLastMoved()
      
    $o(@image).attr 'src', @src
    @$el.append @image

    # force positioning to 0 by default
    @$el.css('left', 0) if $o(@el).css('left') == 'auto' || @$el.css('left') == ''
    @$el.css('top', 0) if $o(@el).css('top') == 'auto' || @$el.css('top') == ''

    @$el
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
      @$el.css 
        width: @image.width
        height: @image.height

  setAsLastMoved: ->
    localStorage.setItem 'last-moved', @id

  render: ->
    @$el

