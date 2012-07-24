describe "Menu", ->

  it "should have the menu_box view accessible via the OverlayMe namespace", ->
    expect(OverlayMe.menu_box).toBeDefined()

  it "should be Draggable", ->
    expect(OverlayMe.menu_box.engageMove).toBeDefined()
    expect(OverlayMe.menu_box.toggleMove).toBeDefined()

  it "should be an appendable list of MenuItems", ->
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

  it "should changed of location when dragged"
    expect('pending').toEqual 'completed'

  it "should have been added at the root of the page as #overlay_me_dev_tools_menu", ->
    expect($('body > #overlay_me_dev_tools_menu').length).toEqual 1

  it "should have moved any content from the original page root into a div #overlay_me_page_container", ->
    expect($o('#overlay_me_page_container > #original_root_level_div').length).toEqual 1

