#= require 'overlay_me/menu'
#= require 'overlay_me/menu_item'

if OverlayMe.mustLoad()

  window.toggle_menu_visibility = ->
    menu = $('#dev-tools-menu')
    if $(menu).css('visibility') == 'visible'
      css = { visibility: 'hidden' }
    else
      css = { visibility: 'visible' }
    $(menu).css(css)
    $(window).trigger 'save:menu'

  basics_panel = new OverlayMe.MenuItem({id: "bacis-options", title: "Basics" })

  clear_all_button = (new Backbone.View).make 'button', { onClick: "javascript: localStorage.clear(); window.location.reload()" }, 'Reset All'
  basics_panel.append clear_all_button

  hide_button = (new Backbone.View).make 'button', { onClick: "javascript: toggle_menu_visibility()" }, 'Hide menu (touch "H")'
  basics_panel.append hide_button

  # add the element to the page menu
  $(OverlayMe.Menu).append basics_panel.render()

  # add listener for keypress
  $(window).bind('keypress', (event) =>
    #console.log event.keyCode
    if event.keyCode == 104 # H
      toggle_menu_visibility()
  )

