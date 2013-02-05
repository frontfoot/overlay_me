#= require 'menu'
#= require 'menu_item'

class OverlayMe.BasicsPanel extends OverlayMe.MenuItem

  panelContent: '
    <span class="reset menu-action" title="Reset All (r)">Reset All</span><!--
    --><span class="hide menu-action" title="Hide (h)">Hide</span>
  '

  initialize: (attributes, options) ->
    super({id: "basics-options-panel", title: "Basics" }, options)

    toggle_all_display = ->
      $o(window).trigger 'overlay_me:toggle_all_display'
      $o(window).trigger 'overlay_me:toggle_overlay_me_images_container_display'

    $o(@el)
      .on 'click', '.reset', (e) =>
        OverlayMe.clearAndReload()
      .on 'click', '.hide', (e) =>
        toggle_all_display()

    template = _.template @panelContent, {}
    @append template

    # add the element to the menu (so yes it has to be there!)
    OverlayMe.menu.append @render()

    # add listeners using keypress - thx to https://github.com/madrobby/keymaster
    key 'h', ->
      toggle_all_display()
    key 'c', ->
      OverlayMe.menu.toggleCollapse()
    key 'r', ->
      OverlayMe.clearAndReload()

# create one at DOM loaded
$o ->
  OverlayMe.basics_panel = new OverlayMe.BasicsPanel() unless OverlayMe.basics_panel
