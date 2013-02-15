class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'div'
  id: 'images_mgnt'
  className: 'images-manager'

  template: '
    <div class="overlays-list"></div>
    <div class="dynamic-adds image-manager__adder" data-behavior="drop-zone">
      <div class="image-manager__adder__unicorns" data-behavior="add-unicorn" title="Feeling corny?"></div>
      Add image
      <div class="image-manager__adder__uploader">
        <input type="file" data-behavior="uploader" />
      </div>
      <input class="image-url-input" type="text" placeholder="http://">
      <button>+</button>
    </div>
  '

  initialize: ->
    @$el = $o(@el)

    $o.event.props.push 'dataTransfer'
    dz       = '[data-behavior~=drop-zone]'
    uploader = '[data-behavior~=uploader]'

    @$el
      # Add unicorns
      .on 'click', '[data-behavior~=add-unicorn]', (e) =>
        @addUnicorn()
      
      # Add image (via url)
      .on 'keypress', 'input', (e) =>
        @pushImage() if e.keyCode == 13
      
      # Add image (via upload)
      .on 'click', 'button', (e) =>
        @pushImage()

      .on 'change', uploader, (e) =>
        @handleUpload e.target.files
        @$el.find(uploader).val '' # Reset field value

      # Add image (via drop)
      .on 'dragover', dz, (e) =>
        @$el.find(dz).addClass 'droppable'
        return false

      .on 'dragleave', dz, (e) =>
        @$el.find(dz).removeClass 'droppable'
          
      .on 'drop', dz, (e) =>
        @handleUpload e.dataTransfer.files
        return false
        

  handleUpload: (files) ->
    _.each files, (file) =>
      if file.type.match 'image.*'
        reader = new FileReader()
        reader.onerror = ->
          alert 'An error occured while uploading the file.'
        reader.onload = (e) =>
          @add e.target.result
        data = reader.readAsDataURL file

  append: (block) ->
    @$el.find('.overlays-list').append block

  del: (imageId) ->
    $o(".overlay-image-block[data-img-id=#{imageId}]", @$el).remove()
    $o("#overlay_me_images_container ##{imageId}").remove()

  add: (source, options = {}) ->
    OverlayMe.dyn_manager.addImage source, options

  addUnicorn: ->
    unicorn = _.shuffle(OverlayMe.unicorns)[0]
    @add unicorn, { css: { opacity: 1 } }

  pushImage: ->
    $urlInput = @$el.find('.image-url-input')
    OverlayMe.dyn_manager.addImage $urlInput.val()
    $urlInput.val ''

  render: ->
    template = _.template @template, {}
    @$el.html template
