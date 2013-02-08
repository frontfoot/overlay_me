#= require 'mixins/storable'

class OverlayMe.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'div'
  className: 'content-mgnt-block section'
  id: 'content_div_management_block'
  css_attributes_to_save: ['z-index', 'opacity']

  normal_zindex: 0
  over_zindex: 5

  template: '
    <div class="slider-block">
      <label for="contentSlider">Page Opacity</label>
      <input id="contentSlider" type="range" value="100">
    </div>
    <div class="zindex-switch">
      <label for="zindex-toggle" title="t">Content on top</label>
      <input type="checkbox" id="zindex-toggle">
    </div>
  '

  initialize: ->

    @$el = $o(@el)

    # move all page content to a sub-Div
    @page_container_div = $o('<div />', {id: 'overlay_me_page_container' })[0]
    $o('body').append @page_container_div
    $o('body > *').each (index, thing) =>
      unless thing.id.match(/^overlay_me/) || thing.tagName == 'SCRIPT'
        $o(@page_container_div).append thing

    # load previous css features of that container div
    @loadCss(@page_container_div, {'z-index': @normal_zindex})

    setTimeout => # have to wait a bit to make sure to access the loaded css
      $o('#zindex-toggle')[0].checked = true if parseInt($o("#overlay_me_page_container").css('z-index'), 10) == @over_zindex
    , 500

    @$el
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
    @$el.html template

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Overlays.ContentDivManagementBlock.prototype, OverlayMe.Mixin.Storable
