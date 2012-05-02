#= require 'overlayme/menu'
#= require 'overlayme/menu_item'
#= require 'overlayme/overlays/init'
#= require 'overlayme/overlays/image'
#= require 'overlayme/overlays/dynamic_image'
#= require 'overlayme/overlays/content_div'
#= require 'overlayme/overlays/images_mngt_div'

# only non tactile devices
if !navigator.userAgent.match /(iPhone|iPod|iPad|Android)/

  # creating a overlay_panel
  overlay_panel = new Overlayme.MenuItem({id: "overlay_panel", title: "Overlays" })

  # adding the #container management block
  overlay_panel.append new Overlayme.Overlays.ContentDivManagementBlock().render()

  # adding image management block
  overlay_panel.append new Overlayme.Overlays.ImagesManagementDiv().render()

  overlay_panel.append new Overlayme.Overlays.DynamicImage('https://a248.e.akamai.net/assets.github.com/images/modules/about_page/octocat.png').render()

  # adding all overlay images
  $.getJSON '/overlay_images', (data) ->
    $.each data, (index, img_path) ->
      overlay_panel.append new Overlayme.Overlays.Image(img_path).render()

  # add the panel to the page menu
  $(Overlayme.Menu).append overlay_panel.render()

  $(window).trigger 'images_should_be_rendred'

  # repeating original window#mousemove event
  $(window).bind('mousemove', (event) ->
    $(window).trigger('mymousemove', event)
  )

