(function() {

  describe("MenuItem", function() {
    var menu_item;
    menu_item = null;
    beforeEach(function() {
      return menu_item = new OverlayMe.MenuItem({
        "class": "menu_item_class",
        title: "menu_item_title"
      });
    });
    it("should have been added to the menu", function() {
      debugger;      return expect($o('ul li.menu_item_class', OverlayMe.menu.el).length).toEqual(1);
    });
    return it("should have a collapsed state", function() {
      debugger;      return expect(menu_item.collapsed).toBeDefined();
    });
  });

}).call(this);
