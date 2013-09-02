OverlayMe.Helpers.urlToId = (url) ->
  url.replace(/[.:\/]/g, '_').replace(/[^a-zA-Z0-9_\-]/g, '')
