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

    @controlBlock.appendChild @hideInactivesBox()
    hide_inactives_label = @make 'label', {}, 'Hide Inactives'
    @controlBlock.appendChild hide_inactives_label
    $o(hide_inactives_label).bind 'click', =>
      $o(@hideInactivesBox).trigger 'click'

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
    dynamicAddsBlock.appendChild @make 'label', {}, 'Add an image'
    @image_url_input = @make 'input', { type: 'text', placeholder: "http://" }
    dynamicAddsBlock.appendChild @image_url_input
    push_image_button = @make 'button', {}, 'Add'
    dynamicAddsBlock.appendChild push_image_button
    $o(@image_url_input).bind 'keypress', (e) =>
      @pushImage() if e.keyCode == 13
    $o(push_image_button).bind 'click', (e) =>
      @pushImage()
    dynamicAddsBlock

  pushImage: ->
    OverlayMe.dyn_manager.addImage @image_url_input.value
    @image_url_input.value = ''

  hideInactivesBox: ->
    @hideInactivesBox = @make 'input', { type: "checkbox", class: 'hide-inactive' }
    # if ( data = localStorage.getItem(@id) )
    #   console.log 'load:', data
    #   $o(@hideInactivesBox).css(JSON.parse(data))
    if $o(@hideInactivesBox).css('visibility') == 'visible'
      @hideInactivesBox.checked = true
    $o(@hideInactivesBox).bind 'change', (event) =>
      @hideInactives()
    @hideInactivesBox

  hideInactives: ->
    checkbox_state = @hideInactivesBox.checked
    _.each $o('.overlay-image-block'), (img_block) ->
      checkbox = $o('input[type=checkbox]', img_block)
      img_id = $o(img_block).attr 'data-img-id'
      if checkbox_state and !checkbox.first()[0].checked
        $o(img_block).hide()
        $o("##{img_id}").hide()
      else
        $o(img_block).show()
        $o("##{img_id}").show()
    @saveState()

  checkAllbox: ->
    @checkAllBox = @make 'input', { type: "checkbox", class: 'check-all' }
    # if ( data = localStorage.getItem(@id) )
    #   console.log 'load:', data
    #   $o(@checkAllBox).css(JSON.parse(data))
    if $o(@checkAllBox).css('visibility') == 'visible'
      @checkAllBox.checked = true
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
    #   visibility:$o(@checkbox).css('visibility')
    # }))

  render: ->
    this.el

