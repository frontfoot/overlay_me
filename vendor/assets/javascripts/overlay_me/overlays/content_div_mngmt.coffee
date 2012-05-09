class OverlayMe.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'fieldset'
  className: 'content-mgnt-block'

  normal_zindex: 0
  over_zindex: 5

  initialize: ->

    our_page_container_div = @make 'div', { id: 'overlay_me_page_container' }
    $('body').append our_page_container_div
    $('body > *').each (index, thing) =>
      unless thing.id.match(/^overlay_me/) || thing.tagName == 'SCRIPT'
        $(our_page_container_div).append thing

    $("#overlay_me_page_container").css({'z-index': @normal_zindex})
    if ( contentCss = localStorage.getItem("#overlay_me_page_container") )
      $("#overlay_me_page_container").css(JSON.parse(contentCss))

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

    @zIndexSwitch = @make 'input', { type: "checkbox" }
    $(block).append @zIndexSwitch

    @zIndexSwitch.checked = true if $("#overlay_me_page_container").css('z-index') == @over_zindex

    label = @make 'label', {}, 'Content on top (touch "c")'
    $(label).bind 'click', =>
      $(@zIndexSwitch).trigger 'click'
    $(block).append label


  contentSlider: ->
    @contentSlider = @make 'input', {
      id: "contentSlider",
      type: "range",
      value: $("#overlay_me_page_container").css('opacity')*100
    }

  bindEvents: ->
    $(@contentSlider).bind('change', =>
      $("#overlay_me_page_container").css('opacity', $(@contentSlider)[0].value/100)
      @saveContentCss()
    )
    $(@zIndexSwitch).bind('change', (event) =>
      if @zIndexSwitch.checked
        $("#overlay_me_page_container").css({'z-index': @over_zindex})
      else
        $("#overlay_me_page_container").css({'z-index': @normal_zindex})
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
    localStorage.setItem("#overlay_me_page_container", JSON.stringify({
      opacity: $("#overlay_me_page_container").css('opacity'),
      'z-index': $("#overlay_me_page_container").css('z-index')
    }))

