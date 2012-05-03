## require menu.coffee and menu_item.coffee to be loaded first !!
# Need the page content to be in #content


# available layouts
layouts = {
  smartphone_portrait: 310,
  smartphone_landscape: 470,
  tablet_port: 758,
  tablet_land: 1014,
  none: null
}

window.resize_page = (width) ->
  if width == null || isNaN(width)
    $('#content').css { width: 'auto' }
  else
    $('#content').css { width: "#{width}px" }

  _.each(layouts, (_width, name) ->
    if width == _width
      $('body').addClass(name)
    else
      $('body').removeClass(name)
  )
  localStorage.setItem "layout-width", width

#load previous state (or null if empty)
window.resize_page parseInt(localStorage.getItem("layout-width"))

# add the buttons to the menu_item
layout_menu = new OverlayMe.MenuItem({id: "layout-buttons", title: "Layout Resizing" })
_.each(layouts, (width, name) ->
  button = (new Backbone.View).make 'button', {}, name
  $(button).addClass name
  $(button).bind 'click', (e) ->
    window.resize_page "#{width}"
  layout_menu.append button
)
# add the element to the page menu
$(OverlayMe.Menu).append layout_menu.render()


