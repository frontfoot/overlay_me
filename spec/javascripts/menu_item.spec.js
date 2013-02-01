(function() {

  describe("MenuItem", function() {
    var menu_item;
    menu_item = null;
    beforeEach(function() {
      localStorage.clear();
      return menu_item = new OverlayMe.MenuItem({
        id: "menu_item_test",
        title: "menu_item_title"
      });
    });
    it("should have a collapsed state", function() {
      return expect(menu_item.collapsed).toBeDefined();
    });
    it("should have a collapsed state false by default", function() {
      return expect(menu_item.collapsed).toBe(false);
    });
    it("should have the id passed in parameters", function() {
      return expect(menu_item.id).toEqual("menu_item_test");
    });
    it("should be collapsable/uncollapsable", function() {
      var coll;
      coll = menu_item.collapsed;
      expect(menu_item.toggleCollapse).toBeDefined();
      menu_item.toggleCollapse();
      return expect(menu_item.collapsed).toEqual(!coll);
    });
    it("can be forced to collapsed", function() {
      menu_item.setCollapse(true);
      return expect(menu_item.collapsed).toEqual(true);
    });
    it("can be forced to uncollapsed", function() {
      menu_item.setCollapse(false);
      return expect(menu_item.collapsed).toEqual(false);
    });
    it("should have a collapsing button (link)", function() {
      return expect($o('a.collapse-button', menu_item.render()).length).toEqual(1);
    });
    it("should have a saveState method", function() {
      return expect(menu_item.saveState).toBeDefined();
    });
    it("should save the collapsed state under a <id>-collapsed key", function() {
      localStorage.clear();
      menu_item.setCollapse(true);
      menu_item.saveState();
      return expect(localStorage.getItem('menu_item_test-collapsed')).toEqual('1');
    });
    it("should save the uncollapsed state under a <id>-collapsed key", function() {
      localStorage.clear();
      menu_item.setCollapse(false);
      menu_item.saveState();
      return expect(localStorage.getItem('menu_item_test-collapsed')).not.toEqual('1');
    });
    it("should load the previous collapsed state at item creation", function() {
      var save_state_test_menu_item;
      localStorage.setItem('save_state_test_menu_item-collapsed', '1');
      save_state_test_menu_item = new OverlayMe.MenuItem({
        id: "save_state_test_menu_item",
        title: "save_state_test_menu_item_title"
      });
      return expect(save_state_test_menu_item.collapsed).toEqual(true);
    });
    return it("should load the previous uncollapsed state at item creation", function() {
      var save_state_test_menu_item;
      localStorage.setItem('save_state_test_menu_item-collapsed', '0');
      save_state_test_menu_item = new OverlayMe.MenuItem({
        id: "save_state_test_menu_item",
        title: "save_state_test_menu_item_title"
      });
      return expect(save_state_test_menu_item.collapsed).toEqual(false);
    });
  });

}).call(this);
