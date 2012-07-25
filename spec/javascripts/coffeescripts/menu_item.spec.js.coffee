describe "MenuItem", ->

  menu_item = null

  beforeEach ->
    menu_item = new OverlayMe.MenuItem({class: "menu_item_class", title: "menu_item_title" })

  it "should have been added to the menu", ->
    debugger
    expect($o('ul li.menu_item_class', OverlayMe.menu.el).length).toEqual 1

  it "should have a collapsed state", ->
    debugger
    expect(menu_item.collapsed).toBeDefined()

