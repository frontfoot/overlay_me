#= require 'draggable'

if OverlayMe.mustLoad()

  # create elements
  OverlayMe.menu_box = new OverlayMe.Draggable { id: 'overlay_me_dev_tools_menu' }, { default_css: { left: document.documentElement.clientWidth-300+'px', top: '0px' } }
  drag_me_line = (new Backbone.View).make 'div', { class: 'drag-me' }, 'Drag me'
  OverlayMe.Menu = (new Backbone.View).make 'ul'

  # stack them together
  $(OverlayMe.menu_box.el).append drag_me_line
  $(OverlayMe.menu_box.el).append OverlayMe.Menu

  # add it to the page
  $('body').append OverlayMe.menu_box.render()

  # add listeners
  $(drag_me_line).bind 'mousedown', (event) =>
    OverlayMe.menu_box.toggleMove(event)
  $(window).bind 'mouseup', (event) =>
    OverlayMe.menu_box.endMove(event)
  $(OverlayMe.menu_box).bind 'toggle:visibility', (event) =>
    if $(OverlayMe.menu_box.el).css('visibility') == 'visible'
      css = { visibility: 'hidden' }
    else
      css = { visibility: 'visible' }
    $(OverlayMe.menu_box.el).css(css)
    OverlayMe.menu_box.saveCss()

