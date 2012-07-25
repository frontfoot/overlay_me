describe "Menu", ->

  it "should be a unique instance of the menu view accessible via the OverlayMe namespace", ->
    expect(OverlayMe.menu).toBeDefined()

  it "should have been appended to the DOM", ->
    expect($o("##{OverlayMe.menu.el.id}").length).toEqual 1

  it "should be Draggable", ->
    expect(OverlayMe.menu.engageMove).toBeDefined()
    expect(OverlayMe.menu.toggleMove).toBeDefined()

  it "should append MenuItems to its list", ->
    expect($o('ul #test-append-li', OverlayMe.menu.el).length).toEqual 0
    test_li = $o('<li id="test-append-li" class="menu-item">Just a test :)</li>')[0] # todo: mock a better test item
    OverlayMe.menu.append(test_li)
    expect($o('ul #test-append-li', OverlayMe.menu.el).length).toEqual 1
    $o('ul #test-append-li', OverlayMe.menu.el).remove()

  it "should be collapsable/uncollapsable", ->
    collapsed = OverlayMe.menu.collapsed()
    OverlayMe.menu.toggleCollapse()
    expect(OverlayMe.menu.collapsed()).toEqual !collapsed
    expect($o(OverlayMe.menu.el).hasClass('collapsed')).toEqual !collapsed

  it "should have been added at the root of the page as #overlay_me_dev_tools_menu", ->
    expect($o('body > #overlay_me_menu').length).toEqual 1



  xit "should have moved any content from the original page root into a div #overlay_me_page_container", ->
  xit "should changed of location when dragged", ->

