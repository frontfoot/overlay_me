(function() {

  describe("Menu", function() {
    it("should have the menu_box view accessible via the OverlayMe namespace", function() {
      return expect(OverlayMe.menu_box).toBeDefined();
    });
    it("should be Draggable", function() {
      expect(OverlayMe.menu_box.engageMove).toBeDefined();
      return expect(OverlayMe.menu_box.toggleMove).toBeDefined();
    });
    it("should changed of location when dragged");
    it("should have been added at the root of the page as #overlay_me_dev_tools_menu", function() {
      return expect($('body > #overlay_me_dev_tools_menu').length).toBe(1);
    });
    return it("should have moved any content from the original page root into a div #overlay_me_page_container", function() {
      return expect($('#overlay_me_dev_tools_menu > #HTMLReporter').length).toBe(1);
    });
  });

}).call(this);
