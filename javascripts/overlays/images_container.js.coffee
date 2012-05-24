class OverlayMe.Overlays.ImagesContainer extends Backbone.View

  initialize: ->
    container = $o('#overlay_me_images_container')
    if container.length < 1 # happen only if the container div doesn't already exist
      container = @make 'div', { id: 'overlay_me_images_container' }
      $o('body').append container
      @el = container
    
