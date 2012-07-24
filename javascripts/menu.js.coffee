#= require 'draggable'

class OverlayMe.MenuClass extends OverlayMe.Draggable

  id: 'overlay_me_menu'

  initialize: (attributes) ->
    super(attributes, { default_css: { top: '50px' } })
    drag_me_line = (new Backbone.View).make 'div', { class: 'drag-me' }, 'Drag me up and down'
    @menu_list = (new Backbone.View).make 'ul'

    # stack them together
    $o(@el).append drag_me_line
    $o(@el).append @menu_list

    # add it to the page
    $o('body').append @render()

    # add listeners
    $o(drag_me_line).bind 'mousedown', (event) =>
      @toggleMove(event)
    $o(window).bind 'mouseup', (event) =>
      @endMove(event)
    $o(window).bind 'overlay_me:toggle_all_display', =>
      @toggleDisplay()

  append: (element) ->
    @menu_list.appendChild element

  toggleCollapse: ->
    if @collapsed()
      $o(@el).removeClass('collapsed')
    else
      $o(@el).addClass('collapsed')

  collapsed: ->
    $o(@el).hasClass('collapsed')


# create only 1 menu
if OverlayMe.mustLoad() # dont do it anytime
  OverlayMe.menu = new OverlayMe.MenuClass() unless OverlayMe.menu_box
