#= require 'overlayme/overlays/image'

class Overlayme.Overlays.DynamicManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      @list = JSON.parse(listJSON)
    else
      @list = []
    console.log 'init dynImages', listJSON

  isPresent: (_id) ->
    for saved in @list
      return true if saved.id == _id
    return false

  addImage: (src) ->
    new_image = new Overlayme.Overlays.Image(src)
    unless @isPresent new_image.image_id
      @list.push { id: new_image.image_id, src: new_image.image_src }
      @saveList()
    new_image

  loadAll: () ->
    for image in @list
      new Overlayme.Overlays.Image(image.src)

  saveList: ->
    console.log 'saving list', @list
    localStorage.setItem('dyn_image_list', JSON.stringify(@list))

