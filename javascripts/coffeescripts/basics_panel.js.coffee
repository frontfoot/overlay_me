#= require 'menu'
#= require 'menu_item'

class OverlayMe.BasicsPanel extends OverlayMe.MenuItem

  initialize: (attributes, options) ->
    super({id: "basics-options-panel", title: "Basics" }, options)

    collapse_button = (new Backbone.View).make 'button', { class: 'collapse'}, 'Collapse (c)'
    $o(collapse_button).bind 'click', (event) =>
      OverlayMe.menu.toggleCollapse()
    @append collapse_button

    clear_all_button = (new Backbone.View).make 'button', { class: 'reset', onClick: "javascript: OverlayMe.clearAndReload()" }, 'Reset All (r)'
    @append clear_all_button

    toggle_all_display = ->
      $o(window).trigger 'overlay_me:toggle_all_display'
      $o(window).trigger 'overlay_me:toggle_overlay_me_images_container_display'

    hide_button = (new Backbone.View).make 'button', { class: 'hide' }, 'Hide (h)'
    $o(hide_button).bind 'click', (event) =>
      toggle_all_display()
    @append hide_button

    # add the element to the menu (so yes it has to be there!)
    OverlayMe.menu.append @render()

    # add listener for keypress
    $o(window).bind('keypress', (event) =>
      # console.log event.keyCode, event.charCode
      if event.charCode == 104 # h
        toggle_all_display()
      if event.charCode == 99 # c
        OverlayMe.menu.toggleCollapse()
      if event.charCode == 114 # r
        OverlayMe.clearAndReload()
    )

# create one at DOM loaded
$o ->
  OverlayMe.basics_panel = new OverlayMe.BasicsPanel() unless OverlayMe.basics_panel
