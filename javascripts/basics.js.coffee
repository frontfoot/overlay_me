#= require 'menu'
#= require 'menu_item'

if OverlayMe.mustLoad() # dont do it twice

  basics_panel = new OverlayMe.MenuItem({id: "bacis-options", title: "Basics" })

  collapse_button = (new Backbone.View).make 'button', { class: 'collapse'}, 'Collapse (c)'
  $o(collapse_button).bind 'click', (event) =>
    OverlayMe.menu.toggleCollapse()
  basics_panel.append collapse_button

  clear_all_button = (new Backbone.View).make 'button', { class: 'reset', onClick: "javascript: OverlayMe.clearAndReload()" }, 'Reset All (r)'
  basics_panel.append clear_all_button

  hide_button = (new Backbone.View).make 'button', { class: 'hide' }, 'Hide (h)'
  $o(hide_button).bind 'click', (event) =>
    $o(window).trigger 'overlay_me:toggle_all_display'
  basics_panel.append hide_button

  # add the element to the page menu
  OverlayMe.menu.append basics_panel.render()

  # add listener for keypress
  $o(window).bind('keypress', (event) =>
    # console.log event.keyCode, event.charCode
    if event.charCode == 104 # h
      $o(window).trigger 'overlay_me:toggle_all_display'
    if event.charCode == 99 # c
      OverlayMe.menu.toggleCollapse()
    if event.charCode == 114 # r
      OverlayMe.clearAndReload()
  )

