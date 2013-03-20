OverlayMe.Mixins.Storable =
  loadCss: (el = @el, css) ->
    return unless @id

    $el = $o(el)

    if cssData = localStorage.getItem(@id)
      $el.css JSON.parse(cssData)
    else if css?
      $el.css css

  saveCss: (el = @el) ->
    return unless @id

    el = el[0] if el instanceof OMjQuery

    @savableCss = ['top', 'left', 'display', 'opacity'] unless @savableCss
    cssData = {}

    for cssProperty in @savableCss
      cssData[cssProperty] = $o(el).css cssProperty

    localStorage.setItem @id, JSON.stringify(cssData)
