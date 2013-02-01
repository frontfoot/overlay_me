#= require 'overlays/images_container'
#= require 'overlays/draggable_image'

class OverlayMe.Overlays.Image extends Backbone.View

  tagName: 'div'
  className: 'overlay-image-block'

  template: '
    <input type="checkbox" checked="<%= checked %>">
    <label><%= name %></label>
    <div class="slider-block">
      <label>Opacity</label>
      <input type="range" value="<%= opacity %>">
    </div>
    <% if(destroyable) { %>
      <button class="del-button" title="Delete">x</button>
    <% } %>
  '

  initialize: (imageSrc, options) ->
    $o.extend { destroyable: false }, options
    @image_src = imageSrc
    @image_id = OverlayMe.Overlays.urlToId imageSrc
    $o(@el).attr 'data-img-id', @image_id

    imagesContainer = new OverlayMe.Overlays.ImagesContainer({ parent_path: options.parent_path })

    @default_css = $o.extend {display: 'none', opacity: 0.5}, options.default_css

    unless $o(imagesContainer.el).find("##{@image_id}").length
      $o(imagesContainer.el).append @image()

    @destroyable = options.destroyable

    $o(@el)
      .on 'change', '[type=checkbox]', (e) =>
        e.stopPropagation()
        @toggleVisibility()
      
      .on 'click', '[type=range]', (e) =>
        e.stopPropagation()
      .on 'change', '[type=range]', (e) =>
        $o(@image.el).css('opacity', parseInt($o(@el).find('[type=range]').val(), 10) / 100)
        @image.saveCss()
      .on 'mouseover', '[type=range]', (e) =>
        e.stopPropagation()
        $o(@el).addClass 'hovered'
      .on 'mouseout', '[type=range]', (e) =>
        e.stopPropagation()
        $o(@el).removeClass 'hovered'

      .on 'click', '.del-button', (e) =>
        OverlayMe.dyn_manager.delImage @image_id

      .on 'click', (e) =>
        e.stopPropagation()
        @toggleChechbox()
      .on 'mouseover', (e) =>
        $o(@image.el).addClass 'highlight'
        $o(@el).addClass 'hovered'
      .on 'mouseout', (e) =>
        $o(@image.el).removeClass 'highlight'
        $o(@el).removeClass 'hovered'

  image: ->
    @image = new OverlayMe.Overlays.DraggableImage { id: @image_id }, { image_src: @image_src, default_css: @default_css }
    @image.render()

  toggleChechbox: ->
    $cb = $o(@el).find('[type=checkbox]')
    $cb[0].checked = !$cb[0].checked
    @toggleVisibility()

  toggleVisibility: ->
    $cb = $o(@el).find('[type=checkbox]')
    $o(@image.el).toggle $cb.is(':checked')
    @image.saveCss()

  opacity: ->
    $o(@image.el).css('opacity') * 100

  # Keept it for legacy
  label: ->
    # keep only 22 characters
    @label = @make 'label', {}, @name()

  name: ->
    @image_src.replace(/.*\//, '').slice -22

  render: ->
    params = {
      checked: if @image.isDisplayed() then 'checked' else false,
      name: @name(),
      opacity: @opacity(),
      destroyable: @destroyable
    }
    template = _.template @template, params
    $o(@el).html template
    @el

