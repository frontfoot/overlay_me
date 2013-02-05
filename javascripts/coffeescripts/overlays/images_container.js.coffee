#= require 'mixins/storable'
#= require 'mixins/hideable'

class OverlayMe.Overlays.ContainerItself extends Backbone.View

  tagName: 'div'
  css_attributes_to_save: ['display']

  initialize: (attributes, options) ->
    super(attributes, options)
    @loadCss()
    $o(window).bind "overlay_me:toggle_#{@id}_display", (event, options) =>
      if options
        if options.show then @show() else @hide()
      else
        @toggleDisplay()

_.extend OverlayMe.Overlays.ContainerItself.prototype, OverlayMe.Mixin.Storable
_.extend OverlayMe.Overlays.ContainerItself.prototype, OverlayMe.Mixin.Hideable




class OverlayMe.Overlays.ImagesContainer extends Backbone.View

  initialize: (options) ->
    # the master image_container will be referenced publicly
    unless OverlayMe.images_container
      OverlayMe.images_container = new OverlayMe.Overlays.ContainerItself id:'overlay_me_images_container', className: 'overlayme-images-container'
      $o('body').append OverlayMe.images_container.el

    # if it's a local file, we build its eventual multi-directories structure
    if options.parent_path
      container = @subDirContainer(options.parent_path)
    # either, the default main container is the one returned
    else
      container = OverlayMe.images_container

    # I know, it's ugly but I just want the proper DOM element, Backbone Object or not
    @el = container.el || container


  subDirContainer: (path, done_bits=[]) ->
    path_bits = _.difference(path.split('/'), _.union(done_bits, ''))
    the_dir = path_bits.slice(0, 1).toString()
    if done_bits.length > 0
      sub_container_parent_post_string = done_bits.join(' ').replace(/\ ?(\w+)/g, ' #$1_container')
    else
      sub_container_parent_post_string = ''

    sub_container = $o("#overlay_me_images_container #{sub_container_parent_post_string} ##{the_dir+'_container'}")
    if sub_container.length < 1 # if the sub_container div doesn't already exist
      sub_container = new OverlayMe.Overlays.ContainerItself id: the_dir+'_container'
      $o("#overlay_me_images_container #{sub_container_parent_post_string}").append sub_container.el

    if path_bits.length > 1
      done_bits.push the_dir
      return @subDirContainer path, done_bits
    else
      return sub_container
      
