OverlayMe.Mixin.Storable = {

  loadCss: (element=@el, default_css) ->
    if ( cssData = localStorage.getItem(@id) )
      $o(element).css(JSON.parse(cssData))
    else
      $o(element).css(default_css) unless default_css == undefined
    
  saveCss: (element=@el) ->
    @css_attributes_to_save = ['top', 'left', 'display', 'opacity'] unless @css_attributes_to_save
    cssData = {}
    for css_attribute in @css_attributes_to_save
      cssData[css_attribute] = $o(element).css(css_attribute)
    localStorage.setItem(@id, JSON.stringify(cssData))

}

