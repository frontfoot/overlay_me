WebDev Toolbar
==============

The original purpose of this tool is to help the developer to meet designers requirements by overlaying images on the page.

We were struggling to see the gap between designers photoshop files and our HTML/CSS implementation, the best way to figure it out was to load their rendered work in the page and play with opacity to see the differences, that's what this tool facilitate.

Features
--------
- images overlay with images position/opacity retention

Todo
----
- include the (already developed) layout resizer block (to switch between pre-recorded devices format layouts)
- add a way to dynamically add new images (by absolute url) to the overlay system
- images sub-sets (directories) should appear as nested blocks

How to use
----------
- Load the compiled plugins.js in your page

  * for us, in haml, using middleman:

    > if "#{Middleman.server.environment}" == 'development'
    > %script{ :src => '/javascripts/webdev_toolbox/plugins.js', :type => 'text/javascript', :charset => 'utf-8' }
    
  * under a rails app:

    > = javascript_include_tag 'webdev_toolbox/plugins.js'

- Then add initialisers variables

   * for rails:

    > WebdevToolbox.root_dir = Dir[Rails.root.join("public")].to_s
    > WebdevToolbox.overlays_directory = 'images/dev_overlays' 
    

Known problems
--------------
- it's version 0.9 as checkboxes and localStorage retention may fail..
- the overlays management system needs your page content to be in a #content or #container div
- when you can't find the panel, it's maybe hidden aside (previous bigger screen location) or hidden (press 'H')

