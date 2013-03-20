class OverlayMe.Models.ImagesManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      @list = JSON.parse(listJSON)
    else
      @list = []

  isPresent: (id) ->
    for saved in @list
      return true if saved.id == id
    false

  isEmpty: ->
    @list.length == 0

  add: (src, options = {} ) ->
    image = @load(src, options)
    if image && !@isPresent(image.image_id)
      @list.push
        id: image.image_id, 
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
      @saveList()
      break

    OverlayMe.imagesManagerView.delete id

  loadAll: () ->
    for image in @list
      @add(image.src)

  saveList: ->
    localStorage.setItem('dyn_image_list', JSON.stringify(@list))

