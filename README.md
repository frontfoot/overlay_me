## Use it now!

Store the bookmarklet from [this page](http://frontfoot.github.com/overlay_me/demo_page.html) and load OverlayMe on top of any web page!

If you just want download the compiled, minified archive: check the [releases](https://github.com/frontfoot/overlay_me/releases)

## Screenshot

![Screenshot](http://github.com/frontfoot/overlay_me/raw/new-design/screenshot_awesomeness_in_action.png)


## Why

The purpose of this tool is to help the developer to meet designers requirements by overlaying images on the page.

We were struggling to see the gap between designers photoshop files and our HTML/CSS implementation, the best way to figure it out was to load their rendered work in the page and play with opacity to see the differences, that's what this tool facilitate.


## Features

- overlay images over a web page
    * move each image by mouse drag or using the arrows (shift arrow to move quicker)
    * position and opacity of each image is saved
    * images can be added on the fly, and will remained
    * hideable / collapsible menu ('h' and 'c' keys)
- HTML on top of the overlays
    * page content can be brought back on top of the overlays ('t' key)
    * control the opacity of the page content
    * keep on playing with the CSS while having the visual overlay by transparency

note: All persistence is made locally to your browser (using HTML5 localStorage)


## Compare

I've found 2 other similar tools so far

- [http://makiapp.com/](http://makiapp.com/) - really nice if you're not a dev guy and want to upload local files
- [http://pixelperfectplugin.com/](http://pixelperfectplugin.com/) - same idea than overlay_me but firefox only (extension) and really less smooth on the dragging


## Todo

- fix styles for firefox and IE (may not happen)
- patch for non-compliant sites
    * the css of some pages break the toolbox css
    * the non working at all sites - http://www.informit.com/articles/article.aspx?p=1383760


## Rack/Rails project integration

There is a gem [rack-overlay_me](https://github.com/frontfoot/rack-overlay_me) that can help you :)

    
## Known problems

- you can't find the panel? it's probably hidden aside (previous bigger screen location) or hidden (press 'h')
- you see the overlay but can't drag it? the 'Content on Top' option is probably on (press 't')


## Contributors

- Tim Petricola - did refactor/clean most of the code, and came up with a nicer design
- Rufus Post - at the origin of the ovelaying concept using CSS
- Dan Smith - User Experience Strategist and Califloridian
- Joseph Boiteau - original author


## License

MIT License
