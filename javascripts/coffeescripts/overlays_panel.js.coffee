#= require 'menu'
#= require 'menu_item'
#= require 'overlays/init'
#= require 'overlays/image'
#= require 'overlays/images_directory'
#= require 'overlays/dynamic_images_mngmt'
#= require 'overlays/content_div_mngmt'
#= require 'overlays/images_mngt_div'

class OverlayMe.OverlaysPanel extends OverlayMe.MenuItem

  initialize: (attributes, options) ->
    super({id: "overlays-panel", title: "Overlays" }, options)

    # adding the #container management block
    @append new OverlayMe.Overlays.ContentDivManagementBlock().render()

    # adding image management block
    OverlayMe.images_management_div = new OverlayMe.Overlays.ImagesManagementDiv()
    @append OverlayMe.images_management_div.render()

    # add the panel to the page menu
    OverlayMe.menu.append @render()
    
    # repeating original window#mousemove event
    $o(window).bind 'mousemove', (event) ->
      $o(window).trigger('mymousemove', event)

    # once everything rendered, load dynamicly added images
    OverlayMe.dyn_manager = new OverlayMe.Overlays.DynamicManager()
    OverlayMe.dyn_manager.loadAll()

    OverlayMe.loadDefaultImage = ->
      # double check that the dynamic loading list is also empty
      if OverlayMe.dyn_manager.isEmpty()
        OverlayMe.dyn_manager.addImage('http://octodex.github.com/images/original.jpg', {css: { left: "#{window.document.width*.6}px"}} )

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
        bits = img_path.split('/')
        position = files_tree
        parent_path = '/'
        while bits.length > 0
          bit = bits[0]
          bits = bits.slice(1)
          continue if bit == ""
          parent_path += bit + '/'
          if position[bit] == undefined
            if bits.length > 0
              position[bit] = { parent_path: parent_path }
            else
              position['files'] = [] if position['files'] == undefined
              position['files'].push bit
          position = position[bit]
      files_tree = shiftTofiles(files_tree)
      displayTree(OverlayMe.images_management_div, files_tree)

    shiftTofiles = (tree) ->
      return tree if tree.files
      keys = Object.keys(tree)
      return tree if keys.length > 2 # parent_path + sub_dir
      keys = _.without(keys, 'parent_path')
      shiftTofiles(tree[keys[0]])

    displayTree = (parent, tree) ->
      for dir in Object.keys(tree)
        continue if dir == 'files' || dir == 'parent_path'
        sub_dir = new OverlayMe.Overlays.ImagesDirectory(dir)
        parent.append sub_dir.render()
        displayTree(sub_dir, tree[dir])
      if tree.files
        for img in tree.files
          parent.append new OverlayMe.Overlays.Image(tree.parent_path+img, { parent_path: tree.parent_path }).render()

# create one at DOM loaded
$o ->
  OverlayMe.overlay_panel = new OverlayMe.OverlaysPanel() unless OverlayMe.overlay_panel
