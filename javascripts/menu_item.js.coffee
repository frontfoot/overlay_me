class OverlayMe.MenuItem extends Backbone.View

  tagName: 'li'
  className: 'menu-item'

  initialize: (attributes, options) ->
    $o(@el).addClass attributes.class
    @el.appendChild @collapseButton()
    @title = this.make 'label', { class: 'title' }, attributes.title
    $o(@title).bind 'click', =>
      @toggleCollapse()
    @el.appendChild @title
    @content = this.make 'div', { class: 'item-content' }
    @el.appendChild @content
    @collapsed = (if localStorage.getItem("#{@id}-collapsed") == '' then false else true)
    @setCollapse @collapsed

  collapseButton: () ->
    @collapseButton = this.make 'a', { class: 'collaps-button' }, '<span>o</span>'
    $o(@collapseButton).bind 'click', =>
      @toggleCollapse()
    @collapseButton

  toggleCollapse: ->
    @collapsed = !@collapsed
    @setCollapse @collapsed
    @saveState()

  setCollapse: (toCollapse) ->
    if toCollapse
      $o(@el).addClass 'collapsed'
    else
      $o(@el).removeClass 'collapsed'

  append: (childElemt) ->
    @content.appendChild childElemt

  render: ->
    @el

  saveState: ->
    localStorage.setItem "#{@id}-collapsed", (if @collapsed then 1 else '')
