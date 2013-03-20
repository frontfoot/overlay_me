#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Draggable extends Backbone.View

  savableCss: ['top', 'left', 'display', 'opacity']

  defaultDragConfig:
    callbacks:
      beforeMove: ->
      afterMove: ->
    axes:
      x: true
      y: true
    boundaries:
      top:    null
      right:  null
      bottom: null
      left:   null

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
    @dragConfig.callbacks.beforeMove.call(@) if typeof @dragConfig.callbacks.beforeMove == 'function'
    @moving = true
    @lastX = event.clientX
    @lastY = event.clientY

    $o(window).bind 'om-mousemove', (event, mouseEvent) =>
      @updatePosition(mouseEvent.clientX - @lastX, mouseEvent.clientY - @lastY)
      @lastX = mouseEvent.clientX
      @lastY = mouseEvent.clientY
    @$el.addClass 'on-move'

  endMove: (event) ->
    @moving = false
    $o(window).unbind('om-mousemove')
    @$el.removeClass 'on-move'
    @dragConfig.callbacks.afterMove.call(@) if typeof @dragConfig.callbacks.afterMove == 'function'

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

    position.left = @updatedAxe('x', x, boundaries) if @dragConfig.axes.x
    position.top  = @updatedAxe('y', y, boundaries) if @dragConfig.axes.y

    @$el.css position
    @save()

  # Get the updated position on a given axe, given boundaries
  updatedAxe: (axe, move, boundaries) ->
    if axe == 'x'
      origin    = 'left'
      opposite  = 'right'
      dimension = 'width'
    else if axe == 'y'
      origin    = 'top'
      opposite  = 'bottom'
      dimension = 'height'
    else
      return false

    outerMethod = "outer#{dimension.charAt(0).toUpperCase()}#{dimension.slice(1)}"

    position = parseInt(@$el.css(origin), 10) + move
    position = boundaries['origin'] if boundaries[origin]? && position < boundaries[origin]
    if boundaries[opposite]?
      winDim           = $o(window)[dimension]()
      elDim            = @$el[outerMethod]()
      oppositePosition = winDim - position - elDim
      position         = winDim - boundaries[opposite] - elDim if oppositePosition < boundaries[opposite]
    position

  save: ->
    @saveCss()

  render: ->
    @$el

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Hideable

