#= require 'draggable'

class OverlayMe.MenuClass extends OverlayMe.Draggable

  id: 'overlay_me_menu'

  className: 'overlayme-menu'

  template: '
    <div class=menu-header data-behavior=drag-menu>
      <span class=menu-header__title>Overlay Me</span>
      <span class=menu-header__reset data-behavior=reset-all></span>
      <span class=menu-header__toggle data-behavior=toggle-menu></span>
    </div>
    <div class="menu-list">
    </div>
  '

  draggable:
    axes:
      x: false
    boundaries:
      top: 0
      bottom: ->
        - ($o('#overlay_me_menu').outerHeight() - $o('.menu-header').outerHeight())

  initialize: (attributes) ->
    super attributes, { css: { top: 50 } }

    @$el = $o(@el)

    toggle = '[data-behavior~=toggle-menu]'
    reset  = '[data-behavior~=reset-all]'
    drag   = '[data-behavior~=drag-menu]'

    # add listeners using keypress - thx to https://github.com/madrobby/keymaster
    key 'h', ->
      OverlayMe.toggle()
    key 'c', ->
      OverlayMe.menu.toggleCollapse()
    key 'r', ->
      OverlayMe.clearAndReload()

    # add it to the page
    $o('body').append @render()

    # add listeners
    @$el
      .on 'mousedown', drag, (e) =>
        @toggleMove e

      .on 'mousedown', "#{toggle}, #{reset}", (e) ->
        e.stopPropagation()

      .on 'click', toggle, (e) ->
        OverlayMe.menu.toggleCollapse()

      .on 'click', reset, (e) ->
        OverlayMe.clearAndReload()

      # Disable scroll on menu hover (to avoid showing scrollbar on chrome)
      .on 'mouseenter', (e) ->
        $o('body').css 'overflow', 'hidden'

      .on 'mouseleave', (e) ->
        $o('body').css 'overflow', ''

    $o(window)
      .on 'mouseup', (e) =>
        @endMove e
      .on 'overlay_me:toggle_all_display', =>
        @toggleDisplay()

  append: (element) ->
    @$el.find('.menu-list').append element

  toggleCollapse: ->
    @$el.toggleClass 'collapsed'
    @updatePosition()

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
