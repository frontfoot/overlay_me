#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Overlays.ImagesContainer extends Backbone.View

  css_attributes_to_save: ['display']

  initialize: (options) ->
    # the master image_container will be referenced publicly
    unless OverlayMe.images_container
      OverlayMe.images_container = @make 'div', { id: 'overlay_me_images_container' }
      $o('body').append OverlayMe.images_container
      # the main_container is listening to the hide_all feature
      $o(window).bind 'overlay_me:toggle_all_display', =>
        @toggleDisplay()
    @el = OverlayMe.images_container
    @id = 'overlay_me_images_container'
    @loadCss()

    # and maybe some sub-containers
    if options.parent_path # for local images only
      path_classes = OverlayMe.Overlays.pathToClasses(options.parent_path)
      sub_container = $o('#overlay_me_images_container '+path_classes.replace(/\ ?(\w+)/g, '.$1'))
      @el = sub_container
      @id = OverlayMe.Overlays.urlToId options.parent_path
      if sub_container.length < 1 # if the sub_container div doesn't already exist
        sub_container = @make 'div', { class: path_classes }
        $o(OverlayMe.images_container).append sub_container
        @el = sub_container
        @id = OverlayMe.Overlays.urlToId options.parent_path
        @loadCss()
        $o(window).bind 'overlay_me:toggle_img_container', (event, options) =>
          if _.include(path_classes.split(' '), options.class)
            if options.show
              @show()
            else
              @hide()
      return sub_container

    # if nothing else has been returned, the default container is the main one
    return OverlayMe.images_container

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Overlays.ImagesContainer.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Overlays.ImagesContainer.prototype, OverlayMe.Mixin.Hideable

