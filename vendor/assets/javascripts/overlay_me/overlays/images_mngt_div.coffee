class OverlayMe.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'fieldset'
  id: 'images_mgnt'

  initialize: ->
    $(@el).append @make 'legend', {}, 'Overlaying images'
    @controlBlock = @make 'div', { class: 'controls' }
    $(@el).append @controlBlock
    @controlBlock.appendChild @checkAllbox()
    @controlBlock.appendChild @make 'label', {}, 'All/None'
    @controlBlock.appendChild @hideInactiveBox()
    @controlBlock.appendChild @make 'label', {}, 'Hide Inactives'

    @overlaysListBlock = @make 'div', { class: 'overlays-list' }
    $(@el).append @overlaysListBlock

    $(@el).append @dynamicAddsBlock()

  append: (block) ->
    @overlaysListBlock.appendChild block

  del: (image_id) ->
    $(".overlay-image-block[data-img-id=#{image_id}]", @el).remove()
    $("#images_container ##{image_id}").remove()

  dynamicAddsBlock: ->
    @dynamicAddsBlock = @make 'div', { class: 'dynamic-adds' }
    @dynamicAddsBlock.appendChild @make 'label', {}, 'Add an image'
    image_text_input = @make 'input', { type: 'text', placeholder: "http://" }
    @dynamicAddsBlock.appendChild image_text_input
    $(image_text_input).bind 'keypress', (e) =>
      if e.charCode == 13
        OverlayMe.dyn_manager.addImage e.target.value
        e.target.value = ''
    @dynamicAddsBlock

  hideInactiveBox: ->
    @hideInactiveBox = @make 'input', { type: "checkbox", class: 'hide-inactive' }
    # if ( data = localStorage.getItem(@id) )
    #   console.log 'load:', data
    #   $(@hideInactiveBox).css(JSON.parse(data))
    if $(@hideInactiveBox).css('visibility') == 'visible'
      @hideInactiveBox.checked = true
    $(@hideInactiveBox).bind 'change', (event) =>
      @hideInactive @hideInactiveBox.checked
      @saveState()
    @hideInactiveBox

  hideInactive: (state) ->
    _.each $('.overlay-image-block'), (img_block) ->
      checkbox = $('input[type=checkbox]', img_block)
      img_id = $(img_block).attr 'data-img-id'
      if state and !checkbox.first()[0].checked
        $(img_block).hide()
        $("##{img_id}").hide()
      else
        $(img_block).show()
        $("##{img_id}").show()

  checkAllbox: ->
    @checkAllBox = @make 'input', { type: "checkbox", class: 'check-all' }
    # if ( data = localStorage.getItem(@id) )
    #   console.log 'load:', data
    #   $(@checkAllBox).css(JSON.parse(data))
    if $(@checkAllBox).css('visibility') == 'visible'
      @checkAllBox.checked = true
    $(@checkAllBox).bind 'change', (event) =>
      @checkAll @checkAllBox.checked
      @saveState()
    @checkAllBox

  checkAll: (state) ->
    for checkbox in $('.overlay-image-block input[type=checkbox]')
      if checkbox.checked != state
        $(checkbox).trigger 'click'


  # adding some retention
  saveState: ->
    # localStorage.setItem(@id, JSON.stringify({
    #   visibility:$(@checkbox).css('visibility')
    # }))

  render: ->
    this.el

