#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Draggable extends Backbone.View

  tagName: 'div'
  css_attributes_to_save: ['top', 'left', 'display', 'opacity']

  initialize: (attributes, options) ->
    super(attributes, options)
    @loadCss(options.default_css)

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

  updateOverlay: (x, y) ->
    newX = parseInt($o(@el).css('left')) + x
    newY = parseInt($o(@el).css('top')) + y
    $o(@el).css({ top:"#{newY}px", left:"#{newX}px"})
    @saveCss()

  render: ->
    @el

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Hideable

