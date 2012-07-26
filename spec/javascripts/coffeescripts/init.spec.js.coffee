describe "Init", ->

  it "must load if loaded flag is not set and the browser is not mobile", ->
    window.overlay_me_loaded = null
    expect(OverlayMe.mustLoad()).toBe(true)

  it "must not load if loaded flag is set", ->
    OverlayMe.setLoaded()
    expect(OverlayMe.mustLoad()).toBe(false)

  it "must not load if mobile", ->
    spyOn(OverlayMe, 'userAgent').andReturn('stuff Android stuff')
    expect(OverlayMe.mustLoad()).toBe(false)

  it "clearAndReload should delete everything from localStorage and try reload the page", ->
    localStorage.setItem('test', 'test')
    spyOn(OverlayMe, 'pageReload').andReturn()
    OverlayMe.clearAndReload()
    expect(localStorage.getItem('test')).toBeNull
    expect(OverlayMe.pageReload).toHaveBeenCalled()

