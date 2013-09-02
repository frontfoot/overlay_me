class OverlayMe.Models.ImagesManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('overlayme-images') )
      @list = JSON.parse(listJSON)
    else
      @list = []

  isPresent: (image) ->
    for saved in @list
      return true if saved.src == image.src
    false

  isEmpty: ->
    @list.length == 0

  add: (src, options = {} ) ->
    image = @load(src, options)
    if image && !@isPresent(image)
      @list.push 
        src: image.src
      @saveList()
    image

  load: (src, options = {} ) ->
    imageId = OverlayMe.Helpers.urlToId(src)

    unless $o("#overlay_me_images_container ##{imageId}").length > 0
      css = $o.extend { display: 'block' }, options.css
      image = new OverlayMe.Views.Image(src, { destroyable: true, css: css })
      OverlayMe.imagesManagerView.append image.render()
    
    image

  delete: (id) ->
    for image in @list
      continue unless image.id == id

      @list.splice(@list.indexOf(image), 1)
      break
    
    @saveList()
    OverlayMe.imagesManagerView.delete id

  loadAll: () ->
    for image in @list
      @add(image.src)

  saveList: ->
    localStorage.setItem('overlayme-images', JSON.stringify(@list))

