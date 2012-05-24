#= require 'draggable'

if OverlayMe.mustLoad() # dont do it twice

  # create elements
  OverlayMe.menu_box = new OverlayMe.Draggable { id: 'overlay_me_dev_tools_menu' }, { default_css: { top: '50px' } }
  drag_me_line = (new Backbone.View).make 'div', { class: 'drag-me' }, 'Drag me up and down'
  OverlayMe.Menu = (new Backbone.View).make 'ul'

  # stack them together
  $o(OverlayMe.menu_box.el).append drag_me_line
  $o(OverlayMe.menu_box.el).append OverlayMe.Menu

  # add it to the page
  $o('body').append OverlayMe.menu_box.render()

  # add listeners
  $o(drag_me_line).bind 'mousedown', (event) =>
    OverlayMe.menu_box.toggleMove(event)
  $o(window).bind 'mouseup', (event) =>
    OverlayMe.menu_box.endMove(event)
  $o(window).bind 'overlay_me:toggle_all_display', =>
    OverlayMe.menu_box.toggleDisplay()
