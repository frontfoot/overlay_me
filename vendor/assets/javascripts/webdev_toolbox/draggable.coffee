class DevTools.Draggable extends Backbone.View

  tagName: 'div'

  initialize: (attributes, options) ->
    super(attributes, options)
    if ( cssData = localStorage.getItem(@id) )
      $(@el).css(JSON.parse(cssData))
    else
      $(@el).css(options.default_css) unless options.default_css == undefined

    _.each options.events_to_save_on, (event_name) =>
      $(window).bind event_name, =>
        @saveCss()

  engageMove: (event) ->
    event.preventDefault()
    @moving = true
    @lastX = event.clientX
    @lastY = event.clientY
    $(window).bind 'mymousemove', (event, mouseEvent) =>
      @updateOverlay(mouseEvent.clientX - @lastX, mouseEvent.clientY - @lastY)
      @lastX = mouseEvent.clientX
      @lastY = mouseEvent.clientY
    $(@el).addClass 'on-move'

  endMove: (event) ->
    @moving = false
    $(window).unbind('mymousemove')
    $(@el).removeClass 'on-move'

  toggleMove: (event) ->
    if @moving
      @endMove(event)
    else
      @engageMove(event)

  updateOverlay: (x, y) ->
    newX = parseInt($(@el).css('left')) + x
    newY = parseInt($(@el).css('top')) + y
    $(@el).css({ top:"#{newY}px", left:"#{newX}px", right: "auto"})
    @saveCss()

  saveCss: () ->
    cssData = {
      top:$(@el).css('top'),
      left:$(@el).css('left'),
      visibility:$(@el).css('visibility'),
      opacity: $(@el).css('opacity')
    }
    localStorage.setItem(@id, JSON.stringify(cssData))

  render: ->
    @el

