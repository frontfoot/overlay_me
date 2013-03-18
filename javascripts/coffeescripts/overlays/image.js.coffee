#= require 'overlays/images_container'
#= require 'overlays/draggable_image'

class OverlayMe.Overlays.Image extends Backbone.View

  tagName: 'article'
  className: 'overlay-image-block image media'

  template: '
    <% if(destroyable) { %>
      <div class="media__action">
        <span class="del-button image__destroy" title="Delete">x</span>
      </div>
    <% } %>
    <div class="media__img">
      <img src="<%= url %>" width=50 alt="<%= name %>">
    </div>
    <div class="media__body">
      <input class="image__toggle" type="checkbox" checked="<%= checked %>">
      <div class="image__name"><%= name %></div>
      <input type="range" class="image__opacity-controller" value="<%= opacity %>">
    </div>
  '

  initialize: (src, options) ->
    $o.extend { destroyable: false }, options

    @$el = $o(@el)

    @src = src
    @id  = OverlayMe.Overlays.urlToId @src
    @$el.attr 'data-img-id', @id

    imagesContainer = new OverlayMe.Overlays.ImagesContainer({ parent_path: options.parent_path })

    @css = $o.extend {display: 'none', opacity: 0.5}, options.css

    unless $o(imagesContainer.el).find("##{@id}").length
      $o(imagesContainer.el).append @image()

    @destroyable = options.destroyable

    @$el
      .on 'change', '[type=checkbox]', (e) =>
        e.stopPropagation()
        @toggleVisibility()
      
      .on 'click', '[type=range]', (e) =>
        e.stopPropagation()
      .on 'change', '[type=range]', (e) =>
        $o(@image.el).css('opacity', parseInt(@$el.find('[type=range]').val(), 10) / 100)
        @image.saveCss()
      .on 'mouseover', '[type=range]', (e) =>
        e.stopPropagation()
        @$el.addClass 'hovered'
      .on 'mouseout', '[type=range]', (e) =>
        e.stopPropagation()
        @$el.removeClass 'hovered'

      .on 'click', '.del-button', (e) =>
        OverlayMe.dyn_manager.delImage @id

      .on 'click', (e) =>
        e.stopPropagation()
        @toggleChechbox()
      .on 'mouseover', (e) =>
        $o(@image.el).addClass 'highlight'
        @$el.addClass 'hovered'
      .on 'mouseout', (e) =>
        $o(@image.el).removeClass 'highlight'
        @$el.removeClass 'hovered'

  image: ->
    @image = new OverlayMe.Overlays.DraggableImage { id: @id }, { src: @src, css: @css }
    @image.render()

  toggleChechbox: ->
    $cb = @$el.find('[type=checkbox]')
    $cb[0].checked = !$cb[0].checked
    @toggleVisibility()

  toggleVisibility: ->
    $cb = @$el.find('[type=checkbox]')
    isChecked = $cb.is(':checked')
    $o(@image.el).toggle isChecked
    @$el.toggleClass 'image--hidden', !isChecked
    @image.saveCss()

  opacity: ->
    $o(@image.el).css('opacity') * 100

  name: ->
    if /http/.test @src
      @src.replace(/.*\//, '').slice(-22)
    else
      ''

  render: ->
    params = {
      checked: if @image.isDisplayed() then 'checked' else false,
      name: @name(),
      opacity: @opacity(),
      destroyable: @destroyable,
      url: @image.src
    }
    template = _.template @template, params
    @$el.html template
