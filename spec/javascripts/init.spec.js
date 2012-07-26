(function() {

  describe("Init", function() {
    it("must load if loaded flag is not set and the browser is not mobile", function() {
      window.overlay_me_loaded = null;
      return expect(OverlayMe.mustLoad()).toBe(true);
    });
    it("must not load if loaded flag is set", function() {
      OverlayMe.setLoaded();
      return expect(OverlayMe.mustLoad()).toBe(false);
    });
    it("must not load if mobile", function() {
      spyOn(OverlayMe, 'userAgent').andReturn('stuff Android stuff');
      return expect(OverlayMe.mustLoad()).toBe(false);
    });
    return it("clearAndReload should delete everything from localStorage and try reload the page", function() {
      localStorage.setItem('test', 'test');
      spyOn(OverlayMe, 'pageReload').andReturn();
      OverlayMe.clearAndReload();
      expect(localStorage.getItem('test')).toBeNull;
      return expect(OverlayMe.pageReload).toHaveBeenCalled();
    });
  });

}).call(this);
