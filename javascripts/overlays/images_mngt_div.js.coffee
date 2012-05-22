class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'fieldset'
  id: 'images_mgnt'

  initialize: ->
    $o(@el).append @make 'legend', {}, 'Overlaying images'
    @controlBlock = @make 'div', { class: 'controls' }
    $o(@el).append @controlBlock

    @controlBlock.appendChild @checkAllbox()
    check_all_label = @make 'label', {}, 'All/None'
    $o(check_all_label).bind 'click', =>
      $o(@checkAllBox).trigger 'click'
    @controlBlock.appendChild check_all_label

    @overlaysListBlock = @make 'div', { class: 'overlays-list' }
    $o(@el).append @overlaysListBlock

    $o(@el).append @dynamicAddsBlock()

  append: (block) ->
    @overlaysListBlock.appendChild block

  del: (image_id) ->
    $o(".overlay-image-block[data-img-id=#{image_id}]", @el).remove()
    $o("#overlay_me_images_container ##{image_id}").remove()

  dynamicAddsBlock: ->
    dynamicAddsBlock = @make 'div', { class: 'dynamic-adds' }
    dynamicAddsBlock.appendChild @make 'label', {}, 'Add image'
    @image_url_input = @make 'input', { type: 'text', placeholder: "http://" }
    dynamicAddsBlock.appendChild @image_url_input
    push_image_button = @make 'button', {}, '+'
    dynamicAddsBlock.appendChild push_image_button
    $o(@image_url_input).bind 'keypress', (e) =>
      @pushImage() if e.keyCode == 13
    $o(push_image_button).bind 'click', (e) =>
      @pushImage()
    dynamicAddsBlock

  pushImage: ->
    OverlayMe.dyn_manager.addImage @image_url_input.value
    @image_url_input.value = ''

  checkAllbox: ->
    @checkAllBox = @make 'input', { type: "checkbox", class: 'check-all' }
    $o(@checkAllBox).bind 'change', (event) =>
      @checkAll()
    @checkAllBox

  checkAll: ->
    checkbox_state = @checkAllBox.checked
    for checkbox in $o('.overlay-image-block input[type=checkbox]')
      if checkbox.checked != checkbox_state
        $o(checkbox).trigger 'click'
    @saveState()

  # adding some retention (or not)
  saveState: ->
    # localStorage.setItem(@id, JSON.stringify({
    # }))

  render: ->
    this.el

