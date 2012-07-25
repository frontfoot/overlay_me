(function() {

  describe("Init", function() {
    it("must load if loaded flag not set and not mobile", function() {
      return expect(OverlayMe.mustLoad()).toBe(true);
    });
    it("must not load if loaded flag set", function() {
      OverlayMe.setLoaded();
      return expect(OverlayMe.mustLoad()).toBe(false);
    });
    it("must not load if mobile", function() {
      spyOn(OverlayMe, 'userAgent').andReturn('stuff Android stuff');
      return expect(OverlayMe.mustLoad()).toBe(false);
    });
    return it("clearAndReload should delete everything from localStorage and try reload page", function() {
      localStorage.setItem('test', 'test');
      spyOn(OverlayMe, 'pageReload').andReturn();
      OverlayMe.clearAndReload();
      expect(localStorage.getItem('test')).toBeNull;
      return expect(OverlayMe.pageReload).toHaveBeenCalled();
    });
  });

}).call(this);
