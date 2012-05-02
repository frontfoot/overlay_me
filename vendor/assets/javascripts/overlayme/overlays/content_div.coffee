class Overlayme.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'div'
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

    $(this.el).append @contentSlider()
    $(this.el).append @zIndexSwitch()
    @bindEvents()

  # adding a checkbox to flip HTML over images
  zIndexSwitch: ->
    block = this.make 'div', { class: 'zindex-switch' }

    @zIndexSwitch = this.make 'input', {
      type: "checkbox",
    }
    $(block).append @zIndexSwitch

    if $("##{@container_id}").css('z-index') == @over_zindex
      @zIndexSwitch.checked = true

    label = this.make 'label', {}, 'HTML ON TOP'
    dToSwap = this.make 'p', {}, 'Hit D to swap'
    $(block).append label
    $(block).append dToSwap


  contentSlider: ->
    @contentSlider = this.make 'input', {
      id: "contentSlider",
      type: "range",
      value: $("##{@container_id}").css('opacity')*100
    }

  bindEvents: ->
    $(@contentSlider).bind('change', =>
      $("##{@container_id}").css({
        opacity: $('#contentSlider')[0].value/100
      })
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
      #console.log event.keyCode, $("##{@container_id}").css('display')
      if event.keyCode == 100 # D
        $(@zIndexSwitch).trigger('click')
    )


  render: ->
    this.el

  # adding some retention for #container
  saveContentCss: ->
    localStorage.setItem("##{@container_id}", JSON.stringify({
      opacity: $("##{@container_id}").css('opacity'),
      'z-index': $("##{@container_id}").css('z-index')
    }))

