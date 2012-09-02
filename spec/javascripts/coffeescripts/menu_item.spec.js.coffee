describe "MenuItem", ->

  menu_item = null

  beforeEach ->
    localStorage.clear()
    menu_item = new OverlayMe.MenuItem({id: "menu_item_test", title: "menu_item_title" })

  it "should have a collapsed state", ->
    expect(menu_item.collapsed).toBeDefined()

  it "should have a collapsed state false by default", ->
    expect(menu_item.collapsed).toBe false

  it "should have the id passed in parameters", ->
    expect(menu_item.id).toEqual "menu_item_test"

  it "should be collapsable/uncollapsable", ->
    coll = menu_item.collapsed
    expect(menu_item.toggleCollapse).toBeDefined()
    menu_item.toggleCollapse()
    expect(menu_item.collapsed).toEqual !coll

  it "can be forced to collapsed", ->
    menu_item.setCollapse true
    expect(menu_item.collapsed).toEqual true

  it "can be forced to uncollapsed", ->
    menu_item.setCollapse false
    expect(menu_item.collapsed).toEqual false

  it "should have a collapsing button (link)", ->
    expect($o('a.collaps-button', menu_item.el).length).toEqual 1

  it "should have an append method appending stuff inside it", ->
    test_span = $o('<span id="test-append-span">Just a test :)</span>')[0] # todo: mock a better test item
    menu_item.append test_span
    expect($o('#test-append-span', menu_item.el).length).toEqual 1

  it "should have a saveState method", ->
    expect(menu_item.saveState).toBeDefined()

  it "should save the collapsed state under a <id>-collapsed key", ->
    localStorage.clear()
    menu_item.setCollapse true
    menu_item.saveState()
    expect(localStorage.getItem('menu_item_test-collapsed')).toEqual '1'

  it "should save the uncollapsed state under a <id>-collapsed key", ->
    localStorage.clear()
    menu_item.setCollapse false
    menu_item.saveState()
    expect(localStorage.getItem('menu_item_test-collapsed')).not.toEqual '1'

  it "should load the previous collapsed state at item creation", ->
    localStorage.setItem('save_state_test_menu_item-collapsed', '1')
    save_state_test_menu_item = new OverlayMe.MenuItem({id: "save_state_test_menu_item", title: "save_state_test_menu_item_title" })
    expect(save_state_test_menu_item.collapsed).toEqual true

  it "should load the previous uncollapsed state at item creation", ->
    localStorage.setItem('save_state_test_menu_item-collapsed', '0')
    save_state_test_menu_item = new OverlayMe.MenuItem({id: "save_state_test_menu_item", title: "save_state_test_menu_item_title" })
    expect(save_state_test_menu_item.collapsed).toEqual false



