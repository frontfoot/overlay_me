#= require 'overlayme/menu'
#= require 'overlayme/menu_item'
#= require 'overlayme/overlays/init'
#= require 'overlayme/overlays/image'
#= require 'overlayme/overlays/dynamic_images_mngt'
#= require 'overlayme/overlays/content_div'
#= require 'overlayme/overlays/images_mngt_div'

# only non tactile devices
if !navigator.userAgent.match /(iPhone|iPod|iPad|Android)/

  # creating a overlay_panel
  overlay_panel = new Overlayme.MenuItem({id: "overlay_panel", title: "Overlays" })

  # adding the #container management block
  overlay_panel.append new Overlayme.Overlays.ContentDivManagementBlock().render()

  # adding image management block
  Overlayme.images_management_div = new Overlayme.Overlays.ImagesManagementDiv()
  overlay_panel.append Overlayme.images_management_div.render()

  # adding all overlay images
  $.getJSON '/overlay_images', (data) ->
    $.each data, (index, img_path) ->
      Overlayme.images_management_div.append new Overlayme.Overlays.Image(img_path).render()

  # add the panel to the page menu
  $(Overlayme.Menu).append overlay_panel.render()
  
  $(window).trigger 'images_should_be_rendred'

  # repeating original window#mousemove event
  $(window).bind('mousemove', (event) ->
    $(window).trigger('mymousemove', event)
  )

  # once everything rendered, load dynamicly added images
  Overlayme.dyn_manager = new Overlayme.Overlays.DynamicManager()
  Overlayme.dyn_manager.loadAll()

  #Overlayme.dyn_manager.addImage('https://a248.e.akamai.net/assets.github.com/images/modules/about_page/octocat.png')


