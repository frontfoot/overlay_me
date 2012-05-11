(function() {
  var layout_menu, layouts;

  layouts = {
    smartphone_portrait: 320,
    smartphone_landscape: 480,
    tablet_port: 768,
    tablet_land: 1024,
    none: null
  };

  window.resize_page = function(width) {
    if (width === null || isNaN(width)) {
      $('#overlay_me_page_container').css({
        width: 'auto'
      });
    } else {
      $('#overlay_me_page_container').css({
        width: "" + width + "px"
      });
    }
    _.each(layouts, function(_width, name) {
      if (width === _width) {
        return $('body').addClass(name);
      } else {
        return $('body').removeClass(name);
      }
    });
    return localStorage.setItem("layout-width", width);
  };

  window.resize_page(parseInt(localStorage.getItem("layout-width")));

  layout_menu = new OverlayMe.MenuItem({
    id: "layout-buttons",
    title: "Layout Resizing"
  });

  _.each(layouts, function(width, name) {
    var button;
    button = (new Backbone.View).make('button', {}, name);
    $(button).addClass(name);
    $(button).bind('click', function(e) {
      return window.resize_page("" + width);
    });
    return layout_menu.append(button);
  });

  $(OverlayMe.Menu).append(layout_menu.render());

}).call(this);
