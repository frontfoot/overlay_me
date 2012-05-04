The original purpose of this tool is to help the developer to meet designers requirements by overlaying images on the page.

We were struggling to see the gap between designers photoshop files and our HTML/CSS implementation, the best way to figure it out was to load their rendered work in the page and play with opacity to see the differences, that's what this tool facilitate.


## Features

- overlay images over a web page saving their position/opacity locally (using HTML5 localStorage)
  * images can be loaded from a local directory
  * any image can also be manually added on the fly with its absolute url
- allow you to bring back your HTML on top of these overlays (asssuming the content of the page is in a #content or #container div)
  * control the opacity of your full page content
  * keep on playing with the CSS while having the overlay there
  * reload the page, settings remain (localStorage)
- addon layout_resizer, to switch between pre-recorded devices format

Try it live [here](http://dev.frontfoot.com.au/overlay_me_demo_page.html) or look at that [screenshot](http://github.com/frontfoot/overlay_me/raw/master/screenshot_frontfoot_website.jpg)


## Todo

- make the script to be usable by non Ruby coders
  * serve a pre-compiled (and even minified) js/css archive
  * make it accessible as a bookmarklet - that would be just awesome
- images sub-sets (directories) should appear as nested blocks
- work on design to make it appealing


## Usage

The project is available as a Ruby gem, so if you too use bundler

    # Gemfile
    
    gem "overlay_me", :git => "git://github.com/frontfoot/overlay_me.git"


### Load the compiled load.js

under a rails app:

    = javascript_include_tag 'overlay_me/load.js'

or in a simpler project, (we are using [middleman](http://middlemanapp.com/))
  
    %script{ :src => '/javascripts/overlay_me/load.js', :type => 'text/javascript', :charset => 'utf-8' }

And that's it ! Reload your page :)


### Extended use - share overlay images to your work team, keep images sets per project

By default the script will try to load the list of images from /overlay_images

List your images in JSON, simply:

    [
      "/images/overlays/Home_1024r_1.png",
      "/images/overlays/Home_1100r_1.jpg",
      "/images/overlays/Home_1300r_1.png",
      "/images/overlays/Home_320r_1.jpg",
      "/images/overlays/Home_480r_1.png",
      "/images/overlays/Home_720r_1.png",
      "/images/overlays/Home_768r_1.png"
    ]

I made a simple Rack app to build that JSON list for you

Here is how to initialise the path and the feed route

using rails

    #config/initializers/overlay_me.rb

    if defined?(OverlayMe)
      OverlayMe.root_dir = Dir[Rails.root.join("public")].to_s
      OverlayMe.overlays_directory = 'images/overlays' 
    end

    #config/routes.rb

    if ["development", "test"].include? Rails.env
      match "/overlay_images" => OverlayMe::App
    end

using middleman

    #config.rb:
    
    OverlayMe.root_dir = Dir.pwd + '/source'
    OverlayMe.overlays_directory = 'images/overlays'

    map "/overlay_images" do
      run OverlayMe::App
    end



## Plug on!

You can add some app specific menu for specific project.. Have a look at layout_resizer.coffee addon to have a quick view of how to use OverlayMe.Menu and OverlayMe.MenuItem

    = javascript_include_tag 'overlay_me/addons/layout_resizer.js'

    

## Known problems

- it's version 0.9x as checkboxes and localStorage retention may be a bit buggy...
- the overlays management system needs your page content to be in a #content or #container div
- when you can't find the panel, it's maybe hidden aside (previous bigger screen location) or hidden (press 'H')
- not a big deal, I tried to bend middleman sprockets configuration to load the stylesheets into /assets but failed... so we try loading both path (see load.coffee)



## Contributors

- Rufus Post - the former working mate who founded the ovelaying concept
- Joseph Boiteau - taking Rufus's idea to 11 (and loving it) - FrontFoot Media Solutions
- Dan Smith - User Experience Strategist and Califloridian - FrontFoot Media Solutions

