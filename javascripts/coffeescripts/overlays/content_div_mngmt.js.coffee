#= require 'mixins/storable'

class OverlayMe.Overlays.ContentDivManagementBlock extends Backbone.View

  tagName: 'div'
  className: 'content-mgnt-block section'
  id: 'content_div_management_block'
  css_attributes_to_save: ['z-index', 'opacity']

  zIndexes: {
    normal: 0,
    over: 5
  }

  template: '
    <div>
      <label for="content-opacity">Page Opacity</label>
      <input id="content-opacity" type="range" value="100" data-behavior="change-content-opacity">
    </div>
    <div>
      <label for="content-on-top" title="t">Content on top</label>
      <input type="checkbox" id="content-on-top" data-behavior="toggle-content-on-top">
    </div>
  '

  initialize: ->
    @$el = $o(@el)

    contentTopToggle = '[data-behavior~=toggle-content-on-top]'
    opacityField     = '[data-behavior~=change-content-opacity]'

    $pageContainer = $o('<div />', {id: 'overlay_me_page_container' }) 
    
    # move all page content to a sub-div
    $o('body')
      .append($pageContainer)
      .each (index, element) =>
        unless element.id.match(/^overlay_me/) || element.tagName == 'SCRIPT'
           $pageContainer.append element

    # load previous css features of that container div
    @loadCss $pageContainer, {'z-index': @zIndexes.normal}

    setTimeout => # have to wait a bit to make sure to access the loaded css
      $o(contentTopToggle)[0].checked = true if parseInt($pageContainer.css('z-index'), 10) == @zIndexes.over
    , 500

    @$el
      .on 'change', opacityField, =>
        $slider = $o(opacityField)
        opacity = parseInt($slider.val(), 10) / 100
        $pageContainer.css 'opacity', opacity
        @saveCss $pageContainer

      .on 'change', contentTopToggle, =>
        zIndex = if $o(contentTopToggle).is ':checked' then @zIndexes.over else @zIndexes.normal
        $pageContainer.css 'z-index', zIndex
        @saveCss $pageContainer

    # if click is kind of boring
    $o(window).on 'keypress', (e) =>
      $o(contentTopToggle).trigger('click') if event.charCode == 116 # t

  render: ->
    template = _.template @template, {}
    @$el.html template

_.extend OverlayMe.Overlays.ContentDivManagementBlock.prototype, OverlayMe.Mixin.Storable
