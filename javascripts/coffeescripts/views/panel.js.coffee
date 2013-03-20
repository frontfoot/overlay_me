class OverlayMe.Views.Panel extends OverlayMe.DraggableView

  id: 'overlay_me_menu'

  className: 'overlayme-menu'

  template: '
    <div class=menu-header data-behavior=drag-menu>
      <span class=menu-header__title>Overlay Me</span>
      <span class=menu-header__reset data-behavior=reset-all></span>
      <span class=menu-header__toggle data-behavior=toggle-menu></span>
    </div>
    <div class="overlays-panel">
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

    # add it to the page
    $o('body').append @render()

    # adding image management block
    OverlayMe.imagesManagerView = new OverlayMe.Views.ImagesManager()
    @append new OverlayMe.Views.PageSettings().render()
    @append OverlayMe.imagesManagerView.render()

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
    @$el.find('.overlays-panel').append element

  toggleCollapse: ->
    @$el.toggleClass 'collapsed'
    @updatePosition()

  collapsed: ->
    @$el.hasClass 'collapsed'

  render: ->
    template = _.template @template, {}
    @$el.html template
