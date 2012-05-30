OverlayMe.Mixin.Hideable = {

  isDisplayed: ->
    element = @el || this
    return $o(element).css('display') != 'none'
  
  toggleDisplay: (default_display_type='block') ->
    if @isDisplayed()
      @hide()
    else
      @show(default_display_type)

  show: (default_display_type='block') ->
    element = @el || this
    $o(element).css { display: default_display_type }
    @saveState()

  hide: ->
    element = @el || this
    $o(element).css { display: 'none' }
    @saveState()

  saveState: ->
    element = @el || this
    @saveCss(element) if @saveCss
}
