OverlayMe.Overlays = {}

OverlayMe.Overlays.urlToId = (url) ->
  return url.replace(/[.:\/]/g, '_').replace(/[^a-zA-Z0-9_\-]/g, '')

OverlayMe.Overlays.pathToClasses = (path) ->
  return _.without(path.split('/'), '').join(' ')

OverlayMe.unicorns = [
  "http://fc07.deviantart.net/fs49/f/2009/200/b/3/Fat_Unicorn_and_the_Rainbow_by_la_ratta.jpg",
  "http://www.deviantart.com/download/126388773/Unicorn_Pukes_Rainbow_by_Angel35W.jpg",
  "http://macmcrae.com/wp-content/uploads/2010/02/unicorn.jpg",
  "http://4.bp.blogspot.com/-uPLiez-m9vY/TacC_Bmsn3I/AAAAAAAAAyg/jusQIA8aAME/s1600/Behold_A_Rainbow_Unicorn_Ninja_by_Jess4921.jpg",
  "http://www.everquestdragon.com/everquestdragon/main/image.axd?picture=2009%2F9%2FPaperPaperNewrainbow.png"
]

