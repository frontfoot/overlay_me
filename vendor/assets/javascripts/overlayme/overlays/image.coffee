#= require 'overlayme/overlays/draggable_image'

class Overlayme.Overlays.Image extends Backbone.View

  tagName: 'div'
  className: 'overlay-image-block'

  initialize: (image_src, options = { destroyable: false }) ->
    @image_src = image_src
    @image_id = image_src.replace(/[.:\/]/g, '_').replace(/[^a-zA-Z0-9_\-]/g, '')
    $(@el).attr 'data-img-id', @image_id

    @images_container = $('#images_container')
    if @images_container.length < 1
      $('body').append (new Backbone.View).make 'div', { id: 'images_container' }
      @images_container = $('#images_container')

    @default_css = $.extend {visibility: 'hidden'}, options.default_css

    unless $("##{@image_id}", @images_container).length > 0
      $(@images_container).append @image()

    $(@el).append @checkbox()
    $(@el).append @label()
    $(@el).append @slider()
    $(@el).append @delButton() if options.destroyable

  image: ->
    @image = new Overlayme.Overlays.DraggableImage { id: @image_id }, { image_src: @image_src, default_css: @default_css }
    @image.render()

  checkbox: ->
    @checkbox = @make 'input', { type: "checkbox" }
    if $(@image.el).css('visibility') == 'visible'
      @checkbox.checked = true
    $(@checkbox).bind 'change', (event) =>
      @flickVisibility()
    @checkbox

  delButton: ->
    @delButton = @make 'button', { class: 'del-button', title: 'Delete' }, 'x'
    $(@delButton).bind 'click', (e) =>
      Overlayme.dyn_manager.delImage @image_id
    @delButton

  flickCheckbox: ->
    @checkbox.checked = !@checkbox.checked
    @flickVisibility()

  flickVisibility: ->
    if @checkbox.checked
      $(@image.el).css('visibility', 'visible')
    else
      $(@image.el).css('visibility', 'hidden')
    @image.saveCss()

  label: ->
    @label = @make 'label', {}, @image_src.replace(/.*\//, '')
    $(@label).bind 'mouseover', (event) =>
      $(@image.el).css('opacity', 1)
      $(@image.el).addClass 'highlight'
    $(@label).bind 'mouseout', (event) =>
      $(@image.el).removeClass 'highlight'
      $(@image.el).css('opacity', $(@slider)[0].value/100)
    $(@label).bind 'click', (event) =>
      @flickCheckbox()

  slider: ->
    @slider = @make 'input', {
      type: "range",
      value: $(@image.el).css('opacity')*100
    }
    $(@slider).bind 'change', =>
      debugger
      $(@image.el).css('opacity', $(@slider)[0].value/100)
      @image.saveCss()
    @slider

  render: ->
    @el

