## Use it now!

Store the bookmarklet from [this page](http://frontfoot.github.com/overlay_me/demo_page.html) and load OverlayMe on top of any web page!

If you just want download the compiled, minified archive: [overlay_me.min.js](https://raw.github.com/frontfoot/overlay_me/master/vendor/assets/javascripts/overlay_me/overlay_me.min.js) (CSS embedded!)

note: overlay_me.js and overlay_me.css are both generated unminified archives, original source code is in javascripts/ and stylesheets/ folders

## Screenshot

![Screenshot](http://github.com/frontfoot/overlay_me/raw/master/screenshot_frontfoot_website.jpg)


## Features

- overlay images over a web page saving their position/opacity locally (using HTML5 localStorage)
  - images can be loaded from a project local directory (see Project base use)
  - an image can be added on the fly with its absolute url
- bring back your HTML on top of the overlays
  - control the opacity of the page content
  - keep on playing with the CSS while having with a visual overlay
- addon layout_resizer, to switch between pre-recorded devices format


## Why

The purpose of this tool is to help the developer to meet designers requirements by overlaying images on the page.

We were struggling to see the gap between designers photoshop files and our HTML/CSS implementation, the best way to figure it out was to load their rendered work in the page and play with opacity to see the differences, that's what this tool facilitate.


## Todo

- fix styles for firefox
- allow local image uploading (hosting on amazon s3 ?), [makiapp.com](http://makiapp.com/) does it!
- add another dragging bar at the bottom (or not)
- prevent the dragging bar(s) to be out of reach
- overlays
  - make a cycling system, by click or keypress, to iterate through overlays one by one
- write some tests !!!



## Usage

- You can use this tool on the go, over any site, via [the bookmarket](http://frontfoot.github.com/overlay_me/demo_page.html)

- If you want to include it in a non-Ruby project, use the precompiled/minified script ([overlay_me.min.js](https://raw.github.com/frontfoot/overlay_me/master/vendor/assets/javascripts/overlay_me/overlay_me.min.js))
  
- And if you're using Ruby, install the gem :)

if using bundler:

    #Gemfile
    
    gem "overlay_me"


### Load the script at the end of your body tag

under a rails app:

    = javascript_include_tag 'overlay_me/overlay_me.min.js'

or in a simpler project, (we are using [middleman](http://middlemanapp.com/))
  
    %script{ :src => '/javascripts/overlay_me/overlay_me.min.js', :type => 'text/javascript', :charset => 'utf-8' }


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

If you're using the gem, I made a simple Rack app to build that JSON list for you

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

- you can't find the panel? it's probably hidden aside (previous bigger screen location) or hidden (press 'h')
- you see the overlay but can't drag it? the 'Content on Top' option is probably on (press 'c')



## Author

- Joseph Boiteau - FrontFoot Media Solutions


## Contributors

- Rufus Post - former workmate at the origin of the ovelaying concept
- Lachlan Sylvester - Ruby advisor - Frontfoot Media Solutions
- Dan Smith - User Experience Strategist and Califloridian - former workmate

