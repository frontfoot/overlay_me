#= require 'webdev_toolbox/menu'
#= require 'webdev_toolbox/menu_item'
#= require 'webdev_toolbox/overlays/init'
#= require 'webdev_toolbox/overlays/image'
#= require 'webdev_toolbox/overlays/content_div'
#= require 'webdev_toolbox/overlays/images_mngt_div'

# only non tactile devices
if !navigator.userAgent.match /(iPhone|iPod|iPad|Android)/

  # creating a overlay_panel
  overlay_panel = new DevTools.MenuItem({id: "overlay_panel", title: "Overlays" })

  # adding the #container management block
  overlay_panel.append new DevTools.Overlays.ContentDivManagementBlock().render()

  # adding image management block
  overlay_panel.append new DevTools.Overlays.ImagesManagementDiv().render()

  # adding all overlay images
  $.getJSON '/overlay_images', (data) ->
    $.each data, (index, img_path) ->
      overlay_panel.append new DevTools.Overlays.Image(img_path).render()

  # add the panel to the page menu
  $(DevTools.Menu).append overlay_panel.render()

  $(window).trigger 'images_should_be_rendred'

  # repeating original window#mousemove event
  $(window).bind('mousemove', (event) ->
    $(window).trigger('mymousemove', event)
  )

