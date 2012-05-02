#= require 'overlayme/overlays/image'

class Overlayme.Overlays.DynamicManager extends Backbone.Model
  
  initialize: () ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      @list = JSON.parse(listJSON)
    else
      @list = []
    @images_mgnt_div = $('#images_mgnt')
    console.log 'init dynImages', listJSON

  isPresent: (_id) ->
    for saved in @list
      return true if saved.id == _id
    return false

  addImage: (src) ->
    new_image = new Overlayme.Overlays.Image(src)
    if @isPresent new_image.image_id
      console.log new_image.image_id, 'already in the panel'
    else
      @list.push { id: new_image.image_id, src: new_image.image_src }
      @images_mgnt_div.append new_image.render()
      @saveList()

  loadAll: () ->
    for image in @list
      reloaded_image = new Overlayme.Overlays.Image(image.src)
      @images_mgnt_div.append reloaded_image.render()

  saveList: ->
    console.log 'saving list', @list, @list.length
    localStorage.setItem('dyn_image_list', JSON.stringify(@list))

