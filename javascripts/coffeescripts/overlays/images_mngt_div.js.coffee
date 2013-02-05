class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'div'
  id: 'images_mgnt'
  className: 'images-manager'

  template: '
    <div class="overlays-list"></div>
    <div class="dynamic-adds image-manager__adder">
      <div class="unicorns image-manager__adder--unicorns" title="Feeling corny?"></div>
      Add image
      <input class="image-url-input" type="text" placeholder="http://">
      <button>+</button>
    </div>
  '

  initialize: ->
    $o(@el)
      .on 'click', '.unicorns', ->
        OverlayMe.dyn_manager.addImage(OverlayMe.unicorns[Math.floor(Math.random()*OverlayMe.unicorns.length)], { default_css: { opacity: 1 } })
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

