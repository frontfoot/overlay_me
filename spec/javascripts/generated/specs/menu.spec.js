(function() {

  describe("Menu", function() {
    it("should be a unique instance of the menu view accessible via the OverlayMe namespace", function() {
      return expect(OverlayMe.menu).toBeDefined();
    });
    it("should have been appended to the DOM", function() {
      return expect($o("#" + OverlayMe.menu.el.id).length).toEqual(1);
    });
    it("should be Draggable", function() {
      expect(OverlayMe.menu.engageMove).toBeDefined();
      return expect(OverlayMe.menu.toggleMove).toBeDefined();
    });
    it("should append MenuItems to its list", function() {
      var test_li;
      expect($o('ul #test-append-li', OverlayMe.menu.el).length).toEqual(0);
      test_li = $o('<li id="test-append-li" class="menu-item">Just a test :)</li>')[0];
      OverlayMe.menu.append(test_li);
      expect($o('ul #test-append-li', OverlayMe.menu.el).length).toEqual(1);
      return $o('ul #test-append-li', OverlayMe.menu.el).remove();
    });
    it("should be collapsable/uncollapsable", function() {
      var collapsed;
      collapsed = OverlayMe.menu.collapsed();
      OverlayMe.menu.toggleCollapse();
      expect(OverlayMe.menu.collapsed()).toEqual(!collapsed);
      return expect($o(OverlayMe.menu.el).hasClass('collapsed')).toEqual(!collapsed);
    });
    it("should have been added at the root of the page as #overlay_me_dev_tools_menu", function() {
      return expect($o('body > #overlay_me_menu').length).toEqual(1);
    });
    xit("should have moved any content from the original page root into a div #overlay_me_page_container", function() {});
    return xit("should changed of location when dragged", function() {});
  });

}).call(this);
