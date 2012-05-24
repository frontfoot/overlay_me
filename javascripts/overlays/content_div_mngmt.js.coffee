#= require 'mixins/storable'

class OverlayMe.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'fieldset'
  className: 'content-mgnt-block'
  id: 'content_div_management_block'
  css_attributes_to_save: ['z-index', 'opacity']

  normal_zindex: '0'
  over_zindex: '5'

  initialize: ->

    # move all page content to a sub-Div
    @page_container_div = @make 'div', { id: 'overlay_me_page_container' }
    $o('body').append @page_container_div
    $o('body > *').each (index, thing) =>
      unless thing.id.match(/^overlay_me/) || thing.tagName == 'SCRIPT'
        $o(@page_container_div).append thing

    # load previous css features of that container div
    @loadCss(@page_container_div, {'z-index': @normal_zindex})

    # adding a hidden unicorny button
    unicorn_button = @make 'div', { class: 'unicorns', title: 'Feeling corny?' }
    $o(unicorn_button).bind 'click', ->
      OverlayMe.dyn_manager.addImage(OverlayMe.unicorns[Math.floor(Math.random()*OverlayMe.unicorns.length)], { default_css: { opacity: 1 } })
    $o(@el).append unicorn_button

    # adding panel elements
    $o(@el).append @make 'legend', {}, 'Page content'
    slider_block = @make 'div', { class: 'slider-block' }
    $o(@el).append slider_block
    slider_block.appendChild @make 'label', {}, 'Opacity'
    slider_block.appendChild @contentSlider()
    $o(@el).append @zIndexSwitch()
    @bindEvents()

  # adding a checkbox to flip HTML over images
  zIndexSwitch: ->
    block = @make 'div', { class: 'zindex-switch' }

    @zIndexSwitch = @make 'input', { type: "checkbox" }
    $o(block).append @zIndexSwitch

    setTimeout => # have to wait a bit to make sure to access the loaded css
      @zIndexSwitch.checked = true if $o("#overlay_me_page_container").css('z-index') == @over_zindex
    , 500

    label = @make 'label', {}, 'Content on top (touch "c")'
    $o(label).bind 'click', =>
      $o(@zIndexSwitch).trigger 'click'
    $o(block).append label


  contentSlider: ->
    @contentSlider = @make 'input', {
      id: "contentSlider",
      type: "range",
      value: $o("#overlay_me_page_container").css('opacity')*100
    }

  bindEvents: ->
    $o(@contentSlider).bind('change', =>
      $o("#overlay_me_page_container").css('opacity', $o(@contentSlider)[0].value/100)
      @saveCss(@page_container_div)
    )
    $o(@zIndexSwitch).bind('change', (event) =>
      if @zIndexSwitch.checked
        $o("#overlay_me_page_container").css({'z-index': @over_zindex})
      else
        $o("#overlay_me_page_container").css({'z-index': @normal_zindex})
      @saveCss(@page_container_div)
    )
    # if click is kind of boring
    $o(window).bind('keypress', (event) =>
      #console.log event.keyCode, event.charCode
      if event.charCode == 99 # C
        $o(@zIndexSwitch).trigger('click')
    )


  render: ->
    @el

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Overlays.ContentDivManagementBlock.prototype, OverlayMe.Mixin.Storable
