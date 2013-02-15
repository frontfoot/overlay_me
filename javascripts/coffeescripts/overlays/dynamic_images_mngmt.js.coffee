#= require 'overlays/image'

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

  addImage: (src, options = {} ) ->
    new_image = @loadImage(src, options)
    if new_image && !@isPresent(new_image.image_id)
      @list.push { id: new_image.image_id, src: new_image.src }
      @saveList()
    new_image

  loadImage: (src, options = {} ) ->
    image_id = OverlayMe.Overlays.urlToId(src)
    unless $o("#overlay_me_images_container ##{image_id}").length > 0
      _default_css = $o.extend { display: 'block' }, options.default_css
      image = new OverlayMe.Overlays.Image(src, { destroyable: true, default_css: _default_css })
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

