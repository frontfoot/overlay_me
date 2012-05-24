OverlayMe.Mixin.Hideable = {

  isDisplayed: ->
    return $o(@el).css('display') != 'none'
  
  toggleDisplay: (default_display_type='block') ->
    if @isDisplayed()
      $o(@el).css { display: 'none' }
    else
      $o(@el).css { display: default_display_type }
    @saveCss()

}
