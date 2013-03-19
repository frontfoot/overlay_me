#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Draggable extends Backbone.View

  tagName: 'div'
  savableCss: ['top', 'left', 'display', 'opacity']

  defaultDragConfig: 
    axes:
      x: true
      y: true
    boundaries:
      top: null
      right: null
      bottom: null
      left: null

  events:
    'save': 'save'

  initialize: (attributes, options) ->
    super(attributes, options)
    @$el = $o(@el)

    # Get configuration (deep extend)
    @dragConfig = {}
    $o.extend true, @dragConfig, @defaultDragConfig, @draggable

    @loadCss @el, options.css

    $o(window).on 'resize', =>
      @updatePosition()


  engageMove: (event) ->
    event.preventDefault()
    @setAsLastMoved()
    @moving = true
    @lastX = event.clientX
    @lastY = event.clientY
    $o(window).bind 'mymousemove', (event, mouseEvent) =>
      @updatePosition(mouseEvent.clientX - @lastX, mouseEvent.clientY - @lastY)
      @lastX = mouseEvent.clientX
      @lastY = mouseEvent.clientY
    @$el.addClass 'on-move'

  endMove: (event) ->
    @moving = false
    $o(window).unbind('mymousemove')
    @$el.removeClass 'on-move'

  toggleMove: (event) ->
    if @moving
      @endMove(event)
    else
      @engageMove(event)

  updatePosition: (x = 0, y = 0) ->
    boundaries = $o.extend {}, @dragConfig.boundaries
    for key, value of boundaries
      boundaries[key] = value() if typeof value is 'function'

    position = {}

    if @dragConfig.axes.x
      left = parseInt(@$el.css('left'), 10) + x
      left = boundaries.left if boundaries.left? && left < boundaries.left
      if boundaries.right?
        winWidth = $o(window).width()
        elWidth  = $o(@el).outerWidth()
        right    = winWidth - left - elWidth
        left     = winWidth - boundaries.left - elWidth if right < boundaries.right
      position.left = left

    if @dragConfig.axes.y
      top = parseInt(@$el.css('top'), 10) + y
      top = boundaries.top if boundaries.top? && top < boundaries.top
      if boundaries.bottom?
        winHeight      = $o(window).height()
        elHeight       = $o(@el).outerHeight()
        bottom         = winHeight - top - elHeight
        top            = winHeight - boundaries.bottom - elHeight if bottom < boundaries.bottom
      position.top = top

    @$el.css position
    @save()

  setAsLastMoved: ->
    localStorage.setItem "last-moved", @id

  save: ->
    @saveCss()

  render: ->
    @$el

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Hideable

