OverlayMe.Mixins.Hideable =
  isDisplayed: ->
    el = @el || this
    $o(el).css('display') != 'none'

  toggleDisplay: ->
    if @isDisplayed()
      @hide()
    else
      @show()

  show: () ->
    el = @el || this
    $o(el).css 'display', ''
    @saveState()

  hide: ->
    el = @el || this
    $o(el).hide()
    @saveState()

  saveState: ->
    el = @el || this
    @saveCss(el) if @saveCss
