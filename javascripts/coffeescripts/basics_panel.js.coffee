#= require 'menu'
#= require 'menu_item'

class OverlayMe.BasicsPanel extends OverlayMe.MenuItem

  panelContent: '
    <span class="reset menu-action" title="Reset All (r)">Reset All</span><!--
    --><span class="hide menu-action" title="Hide (h)">Hide</span>
  '

  initialize: (attributes, options) ->
    super({id: "basics-options-panel", title: "Basics" }, options)

    @$el = $o(@el)

    @$el
      .on 'click', '.reset', (e) =>
        OverlayMe.clearAndReload()
      .on 'click', '.hide', (e) =>
        OverlayMe.toggle()

    template = _.template @panelContent, {}
    @append template

    # add the element to the menu (so yes it has to be there!)
    OverlayMe.menu.append @render()

# create one at DOM loaded
$o ->
  OverlayMe.basics_panel = new OverlayMe.BasicsPanel() unless OverlayMe.basics_panel
