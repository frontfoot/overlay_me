class Overlayme.Overlays.ImagesManagementDiv extends Backbone.View

  tagName: 'div'
  id: 'images_mgnt'

  initialize: ->
    $(@el).append @checkAllbox()
    $(@el).append @make 'label', {}, 'All/None'
    $(@el).append @hideInactiveBox()
    $(@el).append @make 'label', {}, 'Hide Inactives'

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

