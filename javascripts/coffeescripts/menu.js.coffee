#= require 'draggable'

class OverlayMe.MenuClass extends OverlayMe.Draggable

  id: 'overlay_me_menu'

  className: 'overlayme-menu'

  template: '
    <div class="menu-header" data-behavior="drag-menu">
      Overlay Me
      <span class="menu-header__toggle" data-behavior="toggle-menu"></span>
    </div>
    <div class="menu-list">
    </div>
  '

  initialize: (attributes) ->
    super attributes, { css: { top: 50 } }

    @$el = $o(@el)

    toggle = '[data-behavior~=toggle-menu]'
    drag   = '[data-behavior~=drag-menu]'

    # add it to the page
    $o('body').append @render()

    # add listeners
    @$el
      .on 'mousedown', drag, (e) =>
        @toggleMove e

      .on 'mousedown', toggle, (e) ->
        e.stopPropagation()

      .on 'click', toggle, (e) ->
        OverlayMe.menu.toggleCollapse()

    $o(window)
      .on 'mouseup', (e) =>
        @endMove e 
      .on 'overlay_me:toggle_all_display', =>
        @toggleDisplay()

  append: (element) ->
    @$el.find('.menu-list').append element

  toggleCollapse: ->
    @$el.toggleClass 'collapsed'

  collapsed: ->
    @$el.hasClass 'collapsed'

  render: ->
    template = _.template @template, {}
    @$el.html template

# create a unique menu if conditions
if OverlayMe.mustLoad() # dont do it anytime
  # at DOM loaded
  $o ->
    OverlayMe.menu = new OverlayMe.MenuClass() unless OverlayMe.menu
