#= require 'overlays/images_container'
#= require 'overlays/draggable_image'

class OverlayMe.Overlays.Image extends Backbone.View

  tagName: 'div'
  className: 'overlay-image-block'

  initialize: (image_src, options) ->
    $o.extend { destroyable: false }, options
    @image_src = image_src
    @image_id = OverlayMe.Overlays.urlToId(image_src)
    $o(@el).attr 'data-img-id', @image_id

    images_container = new OverlayMe.Overlays.ImagesContainer({parent_path: options.parent_path })

    @default_css = $o.extend {display: 'none', opacity: 0.5}, options.default_css

    unless $o("##{@image_id}", images_container.el).length > 0
      $o(images_container.el).append @image()

    $o(@el).append @checkbox()
    $o(@el).append @label()
    slider_block = @make 'div', { class: 'slider-block' }
    $o(@el).append slider_block
    slider_block.appendChild @make 'label', {}, 'Opacity'
    slider_block.appendChild @slider()
    $o(@el).append @delButton() if options.destroyable
    $o(@el).bind 'click', (e) =>
      e.stopPropagation()
      @flickCheckbox()
    $o(@el).bind 'mouseover', (event) =>
      $o(@image.el).addClass 'highlight'
      $o(@el).addClass 'hovered'
    $o(@el).bind 'mouseout', (event) =>
      $o(@image.el).removeClass 'highlight'
      $o(@el).removeClass 'hovered'


  image: ->
    @image = new OverlayMe.Overlays.DraggableImage { id: @image_id }, { image_src: @image_src, default_css: @default_css }
    @image.render()

  checkbox: ->
    @checkbox = @make 'input', { type: "checkbox" }
    if @image.isDisplayed()
      @checkbox.checked = true
    $o(@checkbox).bind 'click', (e) =>
      e.stopPropagation()
      @flickVisibility()
    $o(@checkbox).bind 'change', (e) =>
      e.stopPropagation()
      @flickVisibility()
    @checkbox

  delButton: ->
    @delButton = @make 'button', { class: 'del-button', title: 'Delete' }, 'x'
    $o(@delButton).bind 'click', (e) =>
      OverlayMe.dyn_manager.delImage @image_id
    @delButton

  flickCheckbox: ->
    @checkbox.checked = !@checkbox.checked
    @flickVisibility()

  flickVisibility: ->
    if @checkbox.checked
      $o(@image.el).css('display', 'block')
    else
      $o(@image.el).css('display', 'none')
    @image.saveCss()

  label: ->
    # keep only 22 characters
    @label = @make 'label', {}, @image_src.replace(/.*\//, '').slice(-22)

  slider: ->
    @slider = @make 'input', {
      type: "range",
      value: $o(@image.el).css('opacity')*100
    }
    $o(@slider).bind 'click', (e) =>
      e.stopPropagation()
    $o(@slider).bind 'change', (e) =>
      $o(@image.el).css('opacity', $o(@slider)[0].value/100)
      @image.saveCss()
    $o(@slider).bind 'mouseover', (e) =>
      e.stopPropagation()
      $o(@el).addClass 'hovered'
    $o(@slider).bind 'mouseout', (e) =>
      e.stopPropagation()
      $o(@el).removeClass 'hovered'
    @slider

  render: ->
    @el

