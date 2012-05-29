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

    # if it's a local file under a multi-directories structure
    if options.parent_path
      return @subDirContainer(options.parent_path)

    # either, the default main container is the one
    return OverlayMe.images_container

  subDirContainer: (path, done_bits=[]) ->
    path_bits = _.difference(path.split('/'), _.union(done_bits, ''))
    the_dir = path_bits.slice(0, 1).toString()
    if done_bits.length > 0
      sub_container_parent_post_string = done_bits.join(' ').replace(/\ ?(\w+)/g, ' #$1_container')
    else
      sub_container_parent_post_string = ''
    sub_container = $o("#overlay_me_images_container #{sub_container_parent_post_string} ##{the_dir+'_container'}")
    if sub_container.length < 1 # if the sub_container div doesn't already exist
      sub_container = @make 'div', { id: the_dir+'_container' }
      $o("#overlay_me_images_container #{sub_container_parent_post_string}").append sub_container
    @el = sub_container
    @id = the_dir+'_container'
    @loadCss()
    $o(window).bind "overlay_me:toggle_#{the_dir}_container", (event, options) =>
      if options.show then @show() else @hide()
    if path_bits.length > 1
      done_bits.push the_dir
      return @subDirContainer path, done_bits
    else
      return sub_container
      
              

# extending few mixins - thx Derick - http://stackoverflow.com/questions/7853731/proper-way-of-doing-view-mixins-in-backbone
_.extend OverlayMe.Overlays.ImagesContainer.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Overlays.ImagesContainer.prototype, OverlayMe.Mixin.Hideable

