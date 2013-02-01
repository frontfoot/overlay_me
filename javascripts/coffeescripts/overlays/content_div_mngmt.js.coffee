#= require 'mixins/storable'

class OverlayMe.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'fieldset'
  className: 'content-mgnt-block'
  id: 'content_div_management_block'
  css_attributes_to_save: ['z-index', 'opacity']

  normal_zindex: 0
  over_zindex: 5

  template: '
    <div class="unicorns" title="Feeling corny?"></div>
    <legend>Page content</legend>
    <div class="slider-block">
      <label>Opacity</label>
      <input id="contentSlider" type="range" value="100">
    </div>
    <div class="zindex-switch">
      <input type="checkbox" id="zindex-toggle">
      <label for="zindex-toggle">Content on top (t)</label>
    </div>
  '

  initialize: ->

    # move all page content to a sub-Div
    @page_container_div = @make 'div', { id: 'overlay_me_page_container' }
    $o('body').append @page_container_div
    $o('body > *').each (index, thing) =>
      unless thing.id.match(/^overlay_me/) || thing.tagName == 'SCRIPT'
        $o(@page_container_div).append thing

    # load previous css features of that container div
    @loadCss(@page_container_div, {'z-index': @normal_zindex})

    setTimeout => # have to wait a bit to make sure to access the loaded css
      $o('#zindex-toggle')[0].checked = true if parseInt($o("#overlay_me_page_container").css('z-index'), 10) == @over_zindex
    , 500

    $o(@el)
      .on 'click', '.unicorns', ->
        OverlayMe.dyn_manager.addImage(OverlayMe.unicorns[Math.floor(Math.random()*OverlayMe.unicorns.length)], { default_css: { opacity: 1 } })

      .on 'change', '#contentSlider', =>
        $slider = $o('#contentSlider')
        opacity = parseInt($slider.val(), 10) / 100
        $o("#overlay_me_page_container").css 'opacity', opacity
        @saveCss @page_container_div

      .on 'change', '#zindex-toggle', =>
        isChecked = $o('#zindex-toggle').is ':checked'
        if isChecked  
          $o('#overlay_me_page_container').css 'z-index', @over_zindex 
        else 
          $o('#overlay_me_page_container').css 'z-index',@normal_zindex
        @saveCss @page_container_div

    # if click is kind of boring
    $o(window).on 'keypress', (e) =>
      $o('#zindex-toggle').trigger('click') if event.charCode == 116 # t


  render: ->
    template = _.template @template, {}
    $o(@el).html template
    @el

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Overlays.ContentDivManagementBlock.prototype, OverlayMe.Mixin.Storable
