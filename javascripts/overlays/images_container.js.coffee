#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Overlays.ImagesContainer extends Backbone.View

  id: 'overlay_me_images_container'
  css_attributes_to_save: ['display']

  initialize: ->
    container = $o('#overlay_me_images_container')
    if container.length < 1 # happen only if the container div doesn't already exist
      container = @make 'div', { id: 'overlay_me_images_container' }
      $o('body').append container
      @el = container
    @loadCss()

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Overlays.ImagesContainer.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Overlays.ImagesContainer.prototype, OverlayMe.Mixin.Hideable

