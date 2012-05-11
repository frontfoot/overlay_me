(function() {
  var layout_menu, layouts;

  layouts = {
    smartphone_portrait: 310,
    smartphone_landscape: 470,
    tablet_port: 758,
    tablet_land: 1014,
    none: null
  };

  window.resize_page = function(width) {
    if (width === null || isNaN(width)) {
      $('#content').css({
        width: 'auto'
      });
    } else {
      $('#content').css({
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
