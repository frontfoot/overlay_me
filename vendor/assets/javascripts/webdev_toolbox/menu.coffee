#= require 'webdev_toolbox/init'
#= require 'webdev_toolbox/draggable'

# only non tactile devices
if !navigator.userAgent.match /(iPhone|iPod|iPad|Android)/

  # create elements
  menu_box = new DevTools.Draggable { id: 'dev-tools-menu' }, { default_css: { left: document.documentElement.clientWidth-300+'px', top: '0px' }, events_to_save_on: ['save:menu']}
  drag_me_line = (new Backbone.View).make 'div', { class: 'drag-me' }, 'Drag me'
  DevTools.Menu = (new Backbone.View).make 'ul'

  # stack them together
  $(menu_box.el).append drag_me_line
  $(menu_box.el).append DevTools.Menu

  # add it to the page
  $('body').append menu_box.render()

  # add listeners
  $(drag_me_line).bind 'mousedown', (event) =>
    menu_box.toggleMove(event)

  $(window).bind 'mouseup', (event) =>
    menu_box.endMove(event)
