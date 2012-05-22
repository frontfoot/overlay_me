#= require 'menu'
#= require 'menu_item'
#= require 'overlays/init'
#= require 'overlays/image'
#= require 'overlays/dynamic_images_mngmt'
#= require 'overlays/content_div_mngmt'
#= require 'overlays/images_mngt_div'

if OverlayMe.mustLoad()

  # creating a overlay_panel
  overlay_panel = new OverlayMe.MenuItem({id: "overlay_panel", title: "Overlays" })

  # adding the #container management block
  overlay_panel.append new OverlayMe.Overlays.ContentDivManagementBlock().render()

  # adding image management block
  OverlayMe.images_management_div = new OverlayMe.Overlays.ImagesManagementDiv()
  overlay_panel.append OverlayMe.images_management_div.render()

  # add the panel to the page menu
  OverlayMe.menu.append overlay_panel.render()
  
  # repeating original window#mousemove event
  $o(window).bind 'mousemove', (event) ->
    $o(window).trigger('mymousemove', event)

  # once everything rendered, load dynamicly added images
  OverlayMe.dyn_manager = new OverlayMe.Overlays.DynamicManager()
  OverlayMe.dyn_manager.loadAll()

  OverlayMe.loadDefaultImage = ->
    # double check that the dynamic loading list is also empty
    if OverlayMe.dyn_manager.isEmpty()
      OverlayMe.dyn_manager.addImage('https://a248.e.akamai.net/assets.github.com/images/modules/about_page/octocat.png')

  # adding all overlay images
  $o.ajax
    url: '/overlay_images'
    dataType: 'json'
    success: (data) ->
      if data.length == 0 # in case all is empty (default for newcomers)
        OverlayMe.loadDefaultImage()
      else
        buildTree data
    error: ->
      OverlayMe.loadDefaultImage()

  files_tree = {}
  buildTree = (data) ->
    $o.each data, (index, img_path) ->
      console.log index, img_path
      bits = img_path.split('/')
      position = files_tree
      while bits.length > 0
        bit = bits[0]
        bits = bits.slice(1)
        continue if bit == ""
        if position[bit] == undefined
          if bits.length > 0
            position[bit] = {}
          else
            position['files'] = [] if position['files'] == undefined
            position['files'].push bit
        position = position[bit]

      OverlayMe.images_management_div.append new OverlayMe.Overlays.Image(img_path).render()
    files_tree = files_tree[Object.keys(files_tree)[0]] while Object.keys(files_tree).length == 1 && Object.keys(files_tree)[0] != "files"
    window.tree = files_tree
    console.log files_tree

