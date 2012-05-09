#= require 'overlay_me/menu'
#= require 'overlay_me/menu_item'
#= require 'overlay_me/overlays/init'
#= require 'overlay_me/overlays/image'
#= require 'overlay_me/overlays/dynamic_images_mngmt'
#= require 'overlay_me/overlays/content_div_mngmt'
#= require 'overlay_me/overlays/images_mngt_div'

if OverlayMe.mustLoad()

  # creating a overlay_panel
  overlay_panel = new OverlayMe.MenuItem({id: "overlay_panel", title: "Overlays" })

  # adding the #container management block
  overlay_panel.append new OverlayMe.Overlays.ContentDivManagementBlock().render()

  # adding image management block
  OverlayMe.images_management_div = new OverlayMe.Overlays.ImagesManagementDiv()
  overlay_panel.append OverlayMe.images_management_div.render()

  OverlayMe.loadDefaultImage = ->
    # double check that the dynamic loading list is also empty
    if OverlayMe.dyn_manager.isEmpty()
      OverlayMe.dyn_manager.addImage('https://a248.e.akamai.net/assets.github.com/images/modules/about_page/octocat.png')

  # adding all overlay images
  $.ajax
    url: '/overlay_images'
    dataType: 'json'
    success: (data) ->
      if data.length == 0 # in case all is empty (default for newcomers)
        OverlayMe.loadDefaultImage()
      else
        $.each data, (index, img_path) ->
          OverlayMe.images_management_div.append new OverlayMe.Overlays.Image(img_path).render()
    error: ->
      OverlayMe.loadDefaultImage()

  # add the panel to the page menu
  $(OverlayMe.Menu).append overlay_panel.render()
  
  # repeating original window#mousemove event
  $(window).bind 'mousemove', (event) ->
    $(window).trigger('mymousemove', event)

  # once everything rendered, load dynamicly added images
  OverlayMe.dyn_manager = new OverlayMe.Overlays.DynamicManager()
  OverlayMe.dyn_manager.loadAll()

  # tag OverlayMe as loaded
  window.overlay_me_loaded = true

