#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Draggable extends Backbone.View

  tagName: 'div'
  css_attributes_to_save: ['top', 'left', 'display', 'opacity']

  events:
    'save': 'save'

  initialize: (attributes, options) ->
    super(attributes, options)
    @loadCss(@el, options.default_css)

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

  updatePosition: (x, y) ->
    $el = $o(@el)
    newX = parseInt($el.css('left'), 10) + x
    newY = parseInt($el.css('top'), 10) + y
    $el.css { 
      top: newY, 
      left: newX
    }
    @save()

  setAsLastMoved: ->
    localStorage.setItem "last-moved", @id

  save: ->
    @saveCss()

  render: ->
    @el

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Draggable.prototype, OverlayMe.Mixin.Hideable

