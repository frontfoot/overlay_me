class OverlayMe.OverlaysPanel extends Backbone.View

  render: ->
    $content = $o(@el)
    _.each @content, (el) ->
      $content.append $o(el)

    @el

  initialize: (attributes, options) ->
    @$el = $o(@el)
    @$el.addClass 'overlays-panel'

    # adding image management block
    OverlayMe.images_management_div = new OverlayMe.Views.ImagesManager()

    # add #container management & image management blocks
    @content = [
      new OverlayMe.Views.PageSettings().render(),
      OverlayMe.images_management_div.render()
    ]

    # add the panel to the page menu
    OverlayMe.menu.append @render()

    # repeating original window#mousemove event
    # to be able to unbind it without interfering with window event
    $o(window).bind 'mousemove', (event) ->
      $o(window).trigger('om-mousemove', event)

    # once everything rendered, load dynamicly added images
    OverlayMe.dyn_manager = new OverlayMe.Models.ImagesManager()
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
        sub_dir = new OverlayMe.Views.ImagesDirectory(dir)
        parent.append sub_dir.render()
        displayTree(sub_dir, tree[dir])
      if tree.files
        for img in tree.files
          parent.append new OverlayMe.Views.Image(tree.parent_path+img, { parent_path: tree.parent_path }).render()

