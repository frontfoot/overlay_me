(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  OverlayMe.OverlaysPanel = (function(_super) {

    __extends(OverlaysPanel, _super);

    OverlaysPanel.name = 'OverlaysPanel';

    function OverlaysPanel() {
      return OverlaysPanel.__super__.constructor.apply(this, arguments);
    }

    OverlaysPanel.prototype.initialize = function(attributes, options) {
      var buildTree, displayTree, files_tree, shiftTofiles;
      OverlaysPanel.__super__.initialize.call(this, {
        id: "overlays-panel",
        title: "Overlays"
      }, options);
      this.append(new OverlayMe.Overlays.ContentDivManagementBlock().render());
      OverlayMe.images_management_div = new OverlayMe.Overlays.ImagesManagementDiv();
      this.append(OverlayMe.images_management_div.render());
      OverlayMe.menu.append(this.render());
      $o(window).bind('mousemove', function(event) {
        return $o(window).trigger('mymousemove', event);
      });
      OverlayMe.dyn_manager = new OverlayMe.Overlays.DynamicManager();
      OverlayMe.dyn_manager.loadAll();
      OverlayMe.loadDefaultImage = function() {
        if (OverlayMe.dyn_manager.isEmpty()) {
          return OverlayMe.dyn_manager.addImage('https://a248.e.akamai.net/assets.github.com/images/modules/about_page/octocat.png', {
            default_css: {
              left: "" + (window.document.width * .6) + "px"
            }
          });
        }
      };
      $o.ajax({
        url: '/overlay_images',
        dataType: 'json',
        success: function(data) {
          if (data.length === 0) {
            return OverlayMe.loadDefaultImage();
          } else {
            return buildTree(data);
          }
        },
        error: function() {
          return OverlayMe.loadDefaultImage();
        }
      });
      files_tree = {};
      buildTree = function(data) {
        $o.each(data, function(index, img_path) {
          var bit, bits, parent_path, position, _results;
          bits = img_path.split('/');
          position = files_tree;
          parent_path = '/';
          _results = [];
          while (bits.length > 0) {
            bit = bits[0];
            bits = bits.slice(1);
            if (bit === "") {
              continue;
            }
            parent_path += bit + '/';
            if (position[bit] === void 0) {
              if (bits.length > 0) {
                position[bit] = {
                  parent_path: parent_path
                };
              } else {
                if (position['files'] === void 0) {
                  position['files'] = [];
                }
                position['files'].push(bit);
              }
            }
            _results.push(position = position[bit]);
          }
          return _results;
        });
        files_tree = shiftTofiles(files_tree);
        return displayTree(OverlayMe.images_management_div, files_tree);
      };
      shiftTofiles = function(tree) {
        var keys;
        if (tree.files) {
          return tree;
        }
        keys = Object.keys(tree);
        if (keys.length > 2) {
          return tree;
        }
        keys = _.without(keys, 'parent_path');
        return shiftTofiles(tree[keys[0]]);
      };
      return displayTree = function(parent, tree) {
        var dir, img, sub_dir, _i, _j, _len, _len1, _ref, _ref1, _results;
        _ref = Object.keys(tree);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dir = _ref[_i];
          if (dir === 'files' || dir === 'parent_path') {
            continue;
          }
          sub_dir = new OverlayMe.Overlays.ImagesDirectory(dir);
          parent.append(sub_dir.render());
          displayTree(sub_dir, tree[dir]);
        }
        if (tree.files) {
          _ref1 = tree.files;
          _results = [];
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            img = _ref1[_j];
            _results.push(parent.append(new OverlayMe.Overlays.Image(tree.parent_path + img, {
              parent_path: tree.parent_path
            }).render()));
          }
          return _results;
        }
      };
    };

    return OverlaysPanel;

  })(OverlayMe.MenuItem);

  $o(function() {
    if (!OverlayMe.overlay_panel) {
      return OverlayMe.overlay_panel = new OverlayMe.OverlaysPanel();
    }
  });

}).call(this);
