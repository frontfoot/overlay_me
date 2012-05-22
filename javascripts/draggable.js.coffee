class OverlayMe.Draggable extends Backbone.View

  tagName: 'div'

  initialize: (attributes, options) ->
    super(attributes, options)
    if ( cssData = localStorage.getItem(@id) )
      $o(@el).css(JSON.parse(cssData))
    else
      $o(@el).css(options.default_css) unless options.default_css == undefined

  engageMove: (event) ->
    event.preventDefault()
    @moving = true
    @lastX = event.clientX
    @lastY = event.clientY
    $o(window).bind 'mymousemove', (event, mouseEvent) =>
      @updateOverlay(mouseEvent.clientX - @lastX, mouseEvent.clientY - @lastY)
      @lastX = mouseEvent.clientX
      @lastY = mouseEvent.clientY
    $o(@el).addClass 'on-move'

  endMove: (event) ->
    @moving = false
    $o(window).unbind('mymousemove')
    $o(@el).removeClass 'on-move'

  toggleMove: (event) ->
    if @moving
      @endMove(event)
    else
      @engageMove(event)

  isDisplayed: ->
    return $o(@el).css('display') != 'none'
  
  toggleDisplay: (default_display_type='block') ->
    if @isDisplayed()
      $o(@el).css { display: 'none' }
    else
      $o(@el).css { display: default_display_type }
    @saveCss()

  updateOverlay: (x, y) ->
    newX = parseInt($o(@el).css('left')) + x
    newY = parseInt($o(@el).css('top')) + y
    $o(@el).css({ top:"#{newY}px", left:"#{newX}px"})
    @saveCss()

  saveCss: () ->
    cssData = {
      top:$o(@el).css('top'),
      left:$o(@el).css('left'),
      display:$o(@el).css('display'),
      opacity: $o(@el).css('opacity')
    }
    localStorage.setItem(@id, JSON.stringify(cssData))

  render: ->
    @el

