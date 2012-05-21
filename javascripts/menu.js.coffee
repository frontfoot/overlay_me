#= require 'draggable'

if OverlayMe.mustLoad()

  # create elements
  OverlayMe.menu_box = new OverlayMe.Draggable { id: 'overlay_me_dev_tools_menu' }, { default_css: { top: '50px' } }
  drag_me_line = (new Backbone.View).make 'div', { class: 'drag-me' }, 'Drag me'
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
  $o(OverlayMe.menu_box).bind 'toggle:visibility', (event) =>
    if $o(OverlayMe.menu_box.el).css('visibility') == 'visible'
      css = { visibility: 'hidden' }
    else
      css = { visibility: 'visible' }
    $o(OverlayMe.menu_box.el).css(css)
    OverlayMe.menu_box.saveCss()

