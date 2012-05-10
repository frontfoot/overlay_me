#= require 'overlay_me/overlays/draggable_image'

class OverlayMe.Overlays.Image extends Backbone.View

  tagName: 'div'
  className: 'overlay-image-block'

  initialize: (image_src, options = { destroyable: false }) ->
    @image_src = image_src
    @image_id = OverlayMe.Overlays.urlToId(image_src)
    $(@el).attr 'data-img-id', @image_id

    @images_container = $('#overlay_me_images_container')
    if @images_container.length < 1
      $('body').append (new Backbone.View).make 'div', { id: 'overlay_me_images_container' }
      @images_container = $('#overlay_me_images_container')

    @default_css = $.extend {visibility: 'hidden', opacity: 0.5}, options.default_css

    unless $("##{@image_id}", @images_container).length > 0
      $(@images_container).append @image()

    $(@el).append @checkbox()
    $(@el).append @label()
    slider_block = @make 'div', { class: 'slider-block' }
    $(@el).append slider_block
    slider_block.appendChild @make 'label', {}, 'Opacity'
    slider_block.appendChild @slider()
    $(@el).append @delButton() if options.destroyable
    $(@el).bind 'click', (event) =>
      @flickCheckbox()
    $(@el).bind 'mouseover', (event) =>
      $(@image.el).css('opacity', 1)
      $(@image.el).addClass 'highlight'
      $(@el).addClass 'hovered'
    $(@el).bind 'mouseout', (event) =>
      $(@image.el).removeClass 'highlight'
      $(@el).removeClass 'hovered'
      $(@image.el).css('opacity', $(@slider)[0].value/100)


  image: ->
    @image = new OverlayMe.Overlays.DraggableImage { id: @image_id }, { image_src: @image_src, default_css: @default_css }
    @image.render()

  checkbox: ->
    @checkbox = @make 'input', { type: "checkbox" }
    if $(@image.el).css('visibility') == 'visible'
      @checkbox.checked = true
    $(@checkbox).bind 'click', (e) =>
      e.stopPropagation()
      @flickVisibility()
    $(@checkbox).bind 'change', (e) =>
      e.stopPropagation()
      @flickVisibility()
    @checkbox

  delButton: ->
    @delButton = @make 'button', { class: 'del-button', title: 'Delete' }, 'x'
    $(@delButton).bind 'click', (e) =>
      OverlayMe.dyn_manager.delImage @image_id
    @delButton

  flickCheckbox: ->
    @checkbox.checked = !@checkbox.checked
    @flickVisibility()

  flickVisibility: ->
    @image.fitDivToImage()
    if @checkbox.checked
      $(@image.el).css('visibility', 'visible')
    else
      $(@image.el).css('visibility', 'hidden')
    @image.saveCss()

  label: ->
    # keep only 22 characters
    @label = @make 'label', {}, @image_src.replace(/.*\//, '').slice(-22)

  slider: ->
    @slider = @make 'input', {
      type: "range",
      value: $(@image.el).css('opacity')*100
    }
    $(@slider).bind 'click', (e) =>
      e.stopPropagation()
    $(@slider).bind 'change', (e) =>
      $(@image.el).css('opacity', $(@slider)[0].value/100)
      @image.saveCss()
    $(@slider).bind 'mouseover', (e) =>
      e.stopPropagation()
      $(@el).addClass 'hovered'
    $(@slider).bind 'mouseout', (e) =>
      e.stopPropagation()
      $(@el).removeClass 'hovered'
    @slider

  render: ->
    @el

