## require menu.coffee and menu_item.coffee to be loaded first !!
# Need the page content to be in #content


# available layouts
layouts = {
  smartphone_portrait: 320,
  smartphone_landscape: 480,
  tablet_port: 768,
  tablet_land: 1024,
  none: null
}

window.resize_page = (width) ->
  if width == null || isNaN(width)
    $o('#overlay_me_page_container').css { width: 'auto' }
  else
    $o('#overlay_me_page_container').css { width: "#{width}px" }

  _.each layouts, (_width, name) ->
    if width == _width
      $o('body').addClass name
    else
      $o('body').removeClass name
  localStorage.setItem "layout-width", width

#load previous state (or null if empty)
window.resize_page parseInt(localStorage.getItem("layout-width"))

# add the buttons to the menu_item
layout_menu = new OverlayMe.MenuItem({id: "layout-buttons", title: "Layout Resizing" })
_.each layouts, (width, name) ->
  button = (new Backbone.View).make 'button', {}, name
  $o(button).addClass name
  $o(button).bind 'click', (e) ->
    window.resize_page "#{width}"
  layout_menu.append button

# add the element to the page menu
$o(OverlayMe.Menu).append layout_menu.render()


