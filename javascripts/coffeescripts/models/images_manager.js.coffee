class OverlayMe.Overlays.ImagesManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      @list = JSON.parse(listJSON)
    else
      @list = []

  isPresent: (imageId) ->
    for saved in @list
      return true if saved.id == imageId
    return false

  isEmpty: ->
    return @list.length == 0

  addImage: (src, options = {} ) ->
    new_image = @loadImage(src, options)
    if new_image && !@isPresent(new_image.image_id)
      @list.push { id: new_image.image_id, src: new_image.src }
      @saveList()
    new_image

  loadImage: (src, options = {} ) ->
    imageId = OverlayMe.Overlays.urlToId(src)
    unless $o("#overlay_me_images_container ##{imageId}").length > 0
      css = $o.extend { display: 'block' }, options.css
      image = new OverlayMe.Overlays.Image(src, { destroyable: true, css: css })
      OverlayMe.images_management_div.append image.render()
    image

  delImage: (imageId) ->
    for image in @list
      if image.id == imageId
        @list.splice(@list.indexOf(image), 1)
        @saveList()
        break
    OverlayMe.images_management_div.del imageId

  loadAll: () ->
    for image in @list
      @addImage(image.src)

  saveList: ->
    localStorage.setItem('dyn_image_list', JSON.stringify(@list))

