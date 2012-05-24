OverlayMe.Mixin.Storable = {

  loadCss: (default_css) ->
    if ( cssData = localStorage.getItem(@id) )
      $o(@el).css(JSON.parse(cssData))
    else
      $o(@el).css(default_css) unless default_css == undefined
    
  saveCss: ->
    @css_attributes_to_save = ['top', 'left', 'display', 'opacity'] unless @css_attributes_to_save
    cssData = {}
    for css_attribute in @css_attributes_to_save
      cssData[css_attribute] = $o(@el).css(css_attribute)
    localStorage.setItem(@id, JSON.stringify(cssData))

}

