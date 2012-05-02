#= require 'overlayme/overlays/image'

class Overlayme.Overlays.DynamicImage extends Overlayme.Overlays.Image

  initialize: (image_src) ->
    super(image_src)
    @add_to_list()
  
  add_to_list: ->
    if ( listJSON = localStorage.getItem('dyn_image_list') )
      console.log 'listJSON', listJSON
      list = JSON.parse(listJSON)
    else
      list = []
    console.log 'dyn_image_list', list
      
    list.push {id: @image_id, src: @image_src}

    console.log 'dyn_image_list', list

    localStorage.setItem('dyn_image_list', JSON.stringify(list))

