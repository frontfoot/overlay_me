class OverlayMe.MenuItem extends Backbone.View

  tagName: 'section'
  className: 'menu-item section'

  template: '
    <a class="collapse-button"></a>
    <div class="item-content"></div>
  '

  initialize: (attributes, options) ->
    @$el = $o(@el)
    
    @id = attributes.id
    @$el.addClass attributes.id

    @title = attributes.title

    @$el
      .on 'click', '.collapse-button, .title', =>
        @toggleCollapse()

    @content = []
    @setCollapse(localStorage.getItem("#{@id}-collapsed") == '1')

  toggleCollapse: ->
    @setCollapse !@collapsed
    @saveState()

  setCollapse: (toCollapse) ->
    @collapsed = toCollapse
    if toCollapse
      @$el.addClass 'collapsed'
    else
      @$el.removeClass 'collapsed'

  append: (childElemt) ->
    @content.push childElemt

  render: ->
    params = {
      title: @title
    }
    template = _.template @template, params
    @$el.html template

    $content = $o(@el).find('.item-content')
    _.each @content, (el) ->
      $content.append $o(el)

    @el

  saveState: ->
    localStorage.setItem "#{@id}-collapsed", (if @collapsed then 1 else 0)
