#= require 'overlay_me/overlays/image'

class OverlayMe.Overlays.DynamicManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      @list = JSON.parse(listJSON)
    else
      @list = []

  isPresent: (image_id) ->
    for saved in @list
      return true if saved.id == image_id
    return false

  isEmpty: ->
    return @list.length == 0

  addImage: (src) ->
    new_image = @loadImage(src)
    unless @isPresent new_image.image_id
      @list.push { id: new_image.image_id, src: new_image.image_src }
      @saveList()
    new_image

  loadImage: (src) ->
    image = undefined
    unless $("#images_container ##{@image_id}").length > 0
      image = new OverlayMe.Overlays.Image(src, { destroyable: true, default_css: {visibility: 'visible'} })
      OverlayMe.images_management_div.append image.render()
    image

  delImage: (image_id) ->
    for image in @list
      if image.id == image_id
        @list.splice(@list.indexOf(image), 1)
        @saveList()
        break
    OverlayMe.images_management_div.del image_id

  loadAll: () ->
    for image in @list
      @addImage(image.src)

  saveList: ->
    localStorage.setItem('dyn_image_list', JSON.stringify(@list))

