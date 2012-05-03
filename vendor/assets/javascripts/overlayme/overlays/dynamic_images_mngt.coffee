#= require 'overlayme/overlays/image'

class Overlayme.Overlays.DynamicManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      @list = JSON.parse(listJSON)
    else
      @list = []

  isPresent: (image_id) ->
    for saved in @list
      return true if saved.id == image_id
    return false

  addImage: (src) ->
    new_image = @loadImage(src)
    unless @isPresent new_image.image_id
      @list.push { id: new_image.image_id, src: new_image.image_src }
      @saveList()
    new_image

  loadImage: (src) ->
    image = undefined
    unless $("#images_container ##{@image_id}").length > 0
      image = new Overlayme.Overlays.Image(src, { destroyable: true, default_css: {visibility: 'visible'} })
      Overlayme.images_management_div.append image.render()
    image

  delImage: (image_id) ->
    for image in @list
      if image.id == image_id
        @list.splice(@list.indexOf(image), 1)
        @saveList()
        break
    Overlayme.images_management_div.del image_id

  loadAll: () ->
    for image in @list
      @addImage(image.src)

  saveList: ->
    localStorage.setItem('dyn_image_list', JSON.stringify(@list))

