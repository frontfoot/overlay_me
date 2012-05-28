#= require 'mixins/hideable'

class OverlayMe.Overlays.ImagesDirectory extends Backbone.View

  tagName: 'div'
  className: 'images_dir'

  initialize: (dirname) ->
    @dirname = dirname

    @contentBlock = @make 'div', { id: @dirname, class: 'sub-block' }
    _.extend @contentBlock, OverlayMe.Mixin.Hideable
    _.extend @contentBlock, OverlayMe.Mixin.Storable
    @contentBlock.css_attributes_to_save = ['display']
    @contentBlock.loadCss(@contentBlock)
    $o(@el).append @checkbox()
    $o(@el).append @label()
    $o(@el).append @contentBlock
    $o(@el).bind 'click', (e) =>
      e.stopPropagation()
      @checkbox.click()

  checkbox: ->
    @checkbox = @make 'input', { type: "checkbox" }
    if @contentBlock.isDisplayed()
      @checkbox.checked = true
    $o(@checkbox).bind 'click', (e) =>
      console.log 'checkbox click'
      e.stopPropagation()
      @flickVisibility()
    $o(@checkbox).bind 'change', (e) =>
      console.log 'checkbox change'
      e.stopPropagation()
      @flickVisibility()
    @checkbox

  flickVisibility: ->
    console.log 'flickVisibility', this
    if @checkbox.checked
      @contentBlock.show()
    else
      @contentBlock.hide()

  label: ->
    @label = @make 'label', {}, '/'+@dirname+'/'

  append: (block) ->
    @contentBlock.appendChild block

  render: ->
    this.el

