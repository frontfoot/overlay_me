class OverlayMe.Overlays.ImagesDirectory extends Backbone.View

  tagName: 'div'
  className: 'images_dir'

  initialize: (dirname) ->
    @$el = $o(@el)

    @dirname = dirname
    @contentBlock = @make 'div', { id: @dirname, class: 'sub-block' }
    _.extend @contentBlock, OverlayMe.Mixin.Hideable
    _.extend @contentBlock, OverlayMe.Mixin.Storable
    @contentBlock.savableCss = ['display']
    @contentBlock.loadCss(@contentBlock)
    @$el.append @checkbox()
    @$el.append @label()
    @$el.append @contentBlock
    @$el.bind 'click', (e) =>
      e.stopPropagation()
      @checkbox.click()

  checkbox: ->
    @checkbox = @make 'input', { type: "checkbox" }
    if @contentBlock.isDisplayed()
      @checkbox.checked = true
    $o(@checkbox).bind 'click', (e) =>
      e.stopPropagation()
      @flickVisibility()
    @checkbox

  flickVisibility: ->
    if @checkbox.checked
      @contentBlock.show()
    else
      @contentBlock.hide()
    $o(window).trigger "overlay_me:toggle_#{@dirname}_container_display", { show: @checkbox.checked }

  label: ->
    @label = @make 'label', {}, '/'+@dirname+'/'

  append: (block) ->
    @contentBlock.appendChild block

  render: ->
    this.el

