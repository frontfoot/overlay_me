class OverlayMe.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'fieldset'
  className: 'content-mgnt-block'

  container_id: 'container'
  normal_zindex: 0
  over_zindex: 5

  initialize: ->

    @container_id = 'content' unless $('#content').length == 0

    $("##{@container_id}").css({'z-index': @normal_zindex})
    if ( contentCss = localStorage.getItem("##{@container_id}") )
      #console.log 'load content:', contentCss
      $("##{@container_id}").css(JSON.parse(contentCss))

    $(@el).append @make 'legend', {}, 'Page content'
    slider_block = @make 'div', { class: 'slider-block' }
    $(@el).append slider_block
    slider_block.appendChild @make 'label', {}, 'Opacity'
    slider_block.appendChild @contentSlider()
    $(@el).append @zIndexSwitch()
    @bindEvents()

  # adding a checkbox to flip HTML over images
  zIndexSwitch: ->
    block = @make 'div', { class: 'zindex-switch' }

    @zIndexSwitch = @make 'input', {
      type: "checkbox",
    }
    $(block).append @zIndexSwitch

    if $("##{@container_id}").css('z-index') == @over_zindex
      @zIndexSwitch.checked = true

    label = @make 'label', {}, 'Content on top (touch "C")'
    $(block).append label


  contentSlider: ->
    @contentSlider = @make 'input', {
      id: "contentSlider",
      type: "range",
      value: $("##{@container_id}").css('opacity')*100
    }

  bindEvents: ->
    $(@contentSlider).bind('change', =>
      $("##{@container_id}").css('opacity', $(@contentSlider)[0].value/100)
      @saveContentCss()
    )
    $(@zIndexSwitch).bind('change', (event) =>
      if @zIndexSwitch.checked
        $("##{@container_id}").css({'z-index': @over_zindex})
      else
        $("##{@container_id}").css({'z-index': @normal_zindex})
      @saveContentCss()
    )
    # if click is kind of boring
    $(window).bind('keypress', (event) =>
      #console.log event.keyCode, event.charCode
      if event.charCode == 99 # C
        $(@zIndexSwitch).trigger('click')
    )


  render: ->
    @el

  # adding some retention for #container
  saveContentCss: ->
    localStorage.setItem("##{@container_id}", JSON.stringify({
      opacity: $("##{@container_id}").css('opacity'),
      'z-index': $("##{@container_id}").css('z-index')
    }))

