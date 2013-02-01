class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'fieldset'
  id: 'images_mgnt'

  template: '
    <legend>Overlaying images</legend>
    <div class="overlays-list"></div>
    <div class="dynamic-adds">
      <label>Add image</label>
      <input class="image-url-input" type="text" placeholder="http://">
      <button>+</button>
    </div>
  '

  initialize: ->
    $o(@el)
      .on 'keypress', 'input', (e) =>
        @pushImage() if e.keyCode == 13
      .on 'click', 'button', (e) =>
        @pushImage()

  append: (block) ->
    $o(@el).find('.overlays-list').append block

  del: (image_id) ->
    $o(".overlay-image-block[data-img-id=#{image_id}]", @el).remove()
    $o("#overlay_me_images_container ##{image_id}").remove()

  pushImage: ->
    $urlInput = $o(@el).find('.image-url-input')
    OverlayMe.dyn_manager.addImage $urlInput.val()
    $urlInput.val ''

  render: ->
    template = _.template @template, {}
    $o(@el).html template
    @el

