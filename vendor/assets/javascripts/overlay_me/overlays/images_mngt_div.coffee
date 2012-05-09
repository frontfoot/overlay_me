class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'fieldset'
  id: 'images_mgnt'

  initialize: ->
    $(@el).append @make 'legend', {}, 'Overlaying images'
    @controlBlock = @make 'div', { class: 'controls' }
    $(@el).append @controlBlock

    @controlBlock.appendChild @checkAllbox()
    check_all_label = @make 'label', {}, 'All/None'
    $(check_all_label).bind 'click', =>
      $(@checkAllBox).trigger 'click'
    @controlBlock.appendChild check_all_label

    @controlBlock.appendChild @hideInactivesBox()
    hide_inactives_label = @make 'label', {}, 'Hide Inactives'
    @controlBlock.appendChild hide_inactives_label
    $(hide_inactives_label).bind 'click', =>
      $(@hideInactivesBox).trigger 'click'

    @overlaysListBlock = @make 'div', { class: 'overlays-list' }
    $(@el).append @overlaysListBlock

    $(@el).append @dynamicAddsBlock()

  append: (block) ->
    @overlaysListBlock.appendChild block

  del: (image_id) ->
    $(".overlay-image-block[data-img-id=#{image_id}]", @el).remove()
    $("#overlay_me_images_container ##{image_id}").remove()

  dynamicAddsBlock: ->
    dynamicAddsBlock = @make 'div', { class: 'dynamic-adds' }
    dynamicAddsBlock.appendChild @make 'label', {}, 'Add an image'
    @image_url_input = @make 'input', { type: 'text', placeholder: "http://" }
    dynamicAddsBlock.appendChild @image_url_input
    push_image_button = @make 'button', {}, 'Add'
    dynamicAddsBlock.appendChild push_image_button
    $(@image_url_input).bind 'keypress', (e) =>
      @pushImage() if e.keyCode == 13
    $(push_image_button).bind 'click', (e) =>
      @pushImage()
    dynamicAddsBlock

  pushImage: ->
    OverlayMe.dyn_manager.addImage @image_url_input.value
    @image_url_input.value = ''

  hideInactivesBox: ->
    @hideInactivesBox = @make 'input', { type: "checkbox", class: 'hide-inactive' }
    # if ( data = localStorage.getItem(@id) )
    #   console.log 'load:', data
    #   $(@hideInactivesBox).css(JSON.parse(data))
    if $(@hideInactivesBox).css('visibility') == 'visible'
      @hideInactivesBox.checked = true
    $(@hideInactivesBox).bind 'change', (event) =>
      @hideInactives()
    @hideInactivesBox

  hideInactives: ->
    checkbox_state = @hideInactivesBox.checked
    _.each $('.overlay-image-block'), (img_block) ->
      checkbox = $('input[type=checkbox]', img_block)
      img_id = $(img_block).attr 'data-img-id'
      if checkbox_state and !checkbox.first()[0].checked
        $(img_block).hide()
        $("##{img_id}").hide()
      else
        $(img_block).show()
        $("##{img_id}").show()
    @saveState()

  checkAllbox: ->
    @checkAllBox = @make 'input', { type: "checkbox", class: 'check-all' }
    # if ( data = localStorage.getItem(@id) )
    #   console.log 'load:', data
    #   $(@checkAllBox).css(JSON.parse(data))
    if $(@checkAllBox).css('visibility') == 'visible'
      @checkAllBox.checked = true
    $(@checkAllBox).bind 'change', (event) =>
      @checkAll()
    @checkAllBox

  checkAll: ->
    checkbox_state = @checkAllBox.checked
    for checkbox in $('.overlay-image-block input[type=checkbox]')
      if checkbox.checked != checkbox_state
        $(checkbox).trigger 'click'
    @saveState()


  # adding some retention (or not)
  saveState: ->
    # localStorage.setItem(@id, JSON.stringify({
    #   visibility:$(@checkbox).css('visibility')
    # }))

  render: ->
    this.el

