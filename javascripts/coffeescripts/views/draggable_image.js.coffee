class OverlayMe.Views.DraggableImage extends OverlayMe.DraggableView

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
    for pos in ['left', 'top']
      @$el.css(pos, 0) if @$el.css(pos) == 'auto' || @$el.css(pos) == ''

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
    return unless @image.width
    @$el.css 
      width: @image.width
      height: @image.height

  setAsLastMoved: ->
    localStorage.setItem 'overlayme-last-moved', @id

  render: ->
    @$el

