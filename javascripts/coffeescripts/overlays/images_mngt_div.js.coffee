class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'div'
  id: 'images_mgnt'
  className: 'images-manager'

  template: '
    <div class="overlays-list"></div>
    <div class="dynamic-adds image-manager__adder" data-behavior="drop-zone">
      <div class="unicorns image-manager__adder--unicorns" title="Feeling corny?"></div>
      Add image
      <input type="file" class="image-uploader" />
      <input class="image-url-input" type="text" placeholder="http://">
      <button>+</button>
    </div>
  '

  initialize: ->
    @$el = $o(@el)

    $o.event.props.push 'dataTransfer'
    dz = '[data-behavior~=drop-zone]'

    @$el
      .on 'click', '.unicorns', (e) ->
        e.stopPropagation()
        OverlayMe.dyn_manager.addImage(OverlayMe.unicorns[Math.floor(Math.random()*OverlayMe.unicorns.length)], { default_css: { opacity: 1 } })
      
      .on 'keypress', 'input', (e) =>
        @pushImage() if e.keyCode == 13
      
      .on 'click', 'button', (e) =>
        e.stopPropagation()
        @pushImage()

      .on 'click', (e) =>
        @$el.find('.image-uploader').trigger ''

      .on 'change', '.image-uploader', (e) =>
        @handleUpload e.target.files

      .on 'dragover', dz, (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$el.find(dz).addClass 'droppable'

      .on 'dragleave', dz, (e) =>
        @$el.find(dz).removeClass 'droppable'
          
      .on 'drop', dz, (e) =>
        e.preventDefault()
        e.stopPropagation()

        @handleUpload e.dataTransfer.files
        

  handleUpload: (files) ->
    _.each files, (file) ->
      if file.type.match 'image.*'
        reader = new FileReader()
        reader.onerror = ->
          alert 'An error occured while uploading the file.'
        reader.onload = (e) ->
          OverlayMe.dyn_manager.addImage e.target.result
        data = reader.readAsDataURL file

  append: (block) ->
    @$el.find('.overlays-list').append block

  del: (image_id) ->
    $o(".overlay-image-block[data-img-id=#{image_id}]", @$el).remove()
    $o("#overlay_me_images_container ##{image_id}").remove()

  pushImage: ->
    $urlInput = @$el.find('.image-url-input')
    OverlayMe.dyn_manager.addImage $urlInput.val()
    $urlInput.val ''

  render: ->
    template = _.template @template, {}
    @$el.html template
