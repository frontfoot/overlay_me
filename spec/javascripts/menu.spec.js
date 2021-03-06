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
    it("should have moved any content from the original page root into a div #overlay_me_page_container", function() {
      return expect($o('#overlay_me_page_container #original_root_level_div').length).toEqual(1);
    });
    return xit("should change of location when dragged", function() {});
  });

}).call(this);
