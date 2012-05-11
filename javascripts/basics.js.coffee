#= require 'menu'
#= require 'menu_item'

if OverlayMe.mustLoad()

  basics_panel = new OverlayMe.MenuItem({id: "bacis-options", title: "Basics" })

  clear_all_button = (new Backbone.View).make 'button', { onClick: "javascript: localStorage.clear(); window.location.reload()" }, 'Reset All'
  basics_panel.append clear_all_button

  hide_button = (new Backbone.View).make 'button', {}, 'Hide menu (touch "h")'
  $(hide_button).bind 'click', (event) =>
    $(OverlayMe.menu_box).trigger 'toggle:visibility'
  basics_panel.append hide_button

  # add the element to the page menu
  $(OverlayMe.Menu).append basics_panel.render()

  # add listener for keypress
  $(window).bind('keypress', (event) =>
    #console.log event.keyCode, event.charCode
    if event.charCode == 104 # H
      $(OverlayMe.menu_box).trigger 'toggle:visibility'
  )

